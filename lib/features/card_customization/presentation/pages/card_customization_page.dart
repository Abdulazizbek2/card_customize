import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_customization_bloc.dart';
import '../widgets/card_preview.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/gradient_picker_widget.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/controls_widget.dart';
import '../../domain/entities/card_customization.dart';

class CardCustomizationPage extends StatefulWidget {
  const CardCustomizationPage({Key? key}) : super(key: key);

  @override
  State<CardCustomizationPage> createState() => _CardCustomizationPageState();
}

class _CardCustomizationPageState extends State<CardCustomizationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  double _baseScale = 1.0;
  Offset _basePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<CardCustomizationBloc>().add(InitializeCard());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Customize Card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      body: BlocConsumer<CardCustomizationBloc, CardCustomizationState>(
        listener: (context, state) {
          if (state is CardCustomizationSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Card customization saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is CardCustomizationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CardCustomizationInitial || state is CardCustomizationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CardCustomizationError && state.customization == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CardCustomizationBloc>().add(InitializeCard());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          final customization = _getCustomization(state);
          if (customization == null) return const SizedBox();

          return Column(
            children: [
              // Card preview section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                color: Colors.white,
                child: Column(
                  children: [
                    GestureDetector(
                      onScaleStart: (details) {
                        if (customization.backgroundType == BackgroundType.image) {
                          _baseScale = customization.imageScale;
                          _basePosition = customization.imagePosition;
                        }
                      },
                      onScaleUpdate: (details) {
                        if (customization.backgroundType == BackgroundType.image) {
                          // Обрабатываем масштабирование
                          if (details.scale != 1.0) {
                            final newScale = (_baseScale * details.scale).clamp(0.8, 3.0);
                            context.read<CardCustomizationBloc>().add(
                                  UpdateImageScale(newScale),
                                );
                          }
                          
                          // Обрабатываем перемещение
                          final newPosition = _basePosition + details.focalPointDelta;
                          context.read<CardCustomizationBloc>().add(
                                UpdateImagePosition(newPosition),
                              );
                        }
                      },
                      child: CardPreview(customization: customization),
                    ),
                    const SizedBox(height: 16),
                    if (customization.backgroundType == BackgroundType.image)
                      Text(
                        'Pinch to zoom • Drag to move',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),

              // Controls section
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: const [
                          Tab(text: 'Colors'),
                          Tab(text: 'Images'),
                          Tab(text: 'Controls'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Colors tab
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  ColorPickerWidget(
                                    selectedColor: customization.backgroundColor ?? Colors.blue,
                                    onColorChanged: (color) {
                                      context.read<CardCustomizationBloc>().add(
                                            SetBackgroundColor(color),
                                          );
                                    },
                                    onGradientPressed: () {
                                      _showGradientPicker(context, customization);
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // Images tab
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: ImagePickerWidget(
                                onPickFromGallery: () {
                                  context.read<CardCustomizationBloc>().add(
                                        PickImageFromGallery()
                                      );
                                },
                                onSelectPredefined: () {
                                  context.read<CardCustomizationBloc>().add(
                                        SelectPredefinedImage()
                                      );
                                },
                              ),
                            ),

                            // Controls tab
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: ControlsWidget(
                                scale: customization.imageScale,
                                blurAmount: customization.blurAmount,
                                onScaleChanged: (scale) {
                                  context.read<CardCustomizationBloc>().add(
                                        UpdateImageScale(scale),
                                      );
                                },
                                onBlurChanged: (blur) {
                                  context.read<CardCustomizationBloc>().add(
                                        UpdateBlurAmount(blur),
                                      );
                                },
                                onSave: () {
                                  context.read<CardCustomizationBloc>().add(SaveCard());
                                },
                                isSaving: state is CardCustomizationSaving,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  CardCustomization? _getCustomization(CardCustomizationState state) {
    if (state is CardCustomizationLoaded) return state.customization;
    if (state is CardCustomizationSaving) return state.customization;
    if (state is CardCustomizationSaved) return state.customization;
    if (state is CardCustomizationError) return state.customization;
    return null;
  }

  void _showGradientPicker(BuildContext context, CardCustomization customization) {
    final bloc = context.read<CardCustomizationBloc>();
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: bloc,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientPickerWidget(
                selectedGradient: customization.backgroundGradient,
                onGradientChanged: (gradient) {
                  bloc.add(SetBackgroundGradient(gradient));
                  Navigator.pop(bottomSheetContext);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(bottomSheetContext),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
