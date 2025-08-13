import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/card_customization.dart';
import '../../domain/usecases/save_card_customization.dart';
import '../../domain/usecases/pick_image_from_gallery.dart' as pick_image_usecase;
import '../../domain/usecases/get_predefined_image.dart';
import '../../../../core/constants/app_constants.dart';

part 'card_customization_event.dart';
part 'card_customization_state.dart';

class CardCustomizationBloc extends Bloc<CardCustomizationEvent, CardCustomizationState> {
  final SaveCardCustomization saveCardCustomization;
  final pick_image_usecase.PickImageFromGallery pickImageFromGalleryUseCase;
  final GetPredefinedImage getPredefinedImage;

  CardCustomizationBloc({
    required this.saveCardCustomization,
    required this.pickImageFromGalleryUseCase,
    required this.getPredefinedImage,
  }) : super(CardCustomizationInitial()) {
    on<InitializeCard>(_onInitializeCard);
    on<PickImageFromGallery>(_onPickImageFromGallery);
    on<SelectPredefinedImage>(_onSelectPredefinedImage);
    on<SetBackgroundColor>(_onSetBackgroundColor);
    on<SetBackgroundGradient>(_onSetBackgroundGradient);
    on<UpdateImageScale>(_onUpdateImageScale);
    on<UpdateImagePosition>(_onUpdateImagePosition);
    on<UpdateBlurAmount>(_onUpdateBlurAmount);
    on<SaveCard>(_onSaveCard);
  }

  void _onInitializeCard(InitializeCard event, Emitter<CardCustomizationState> emit) async {
    emit(CardCustomizationLoading());
    
    // Randomly select a predefined color or gradient
    final random = Random();
    final useGradient = random.nextBool();
    
    CardCustomization initialCustomization;
    
    if (useGradient) {
      final gradient = AppConstants.predefinedGradients[
          random.nextInt(AppConstants.predefinedGradients.length)];
      initialCustomization = CardCustomization(
        backgroundType: BackgroundType.gradient,
        backgroundGradient: gradient,
        blurAmount: AppConstants.defaultBlur,
        imageScale: AppConstants.defaultScale,
        imagePosition: Offset.zero,
      );
    } else {
      final color = AppConstants.predefinedColors[
          random.nextInt(AppConstants.predefinedColors.length)];
      initialCustomization = CardCustomization(
        backgroundType: BackgroundType.color,
        backgroundColor: color,
        blurAmount: AppConstants.defaultBlur,
        imageScale: AppConstants.defaultScale,
        imagePosition: Offset.zero,
      );
    }
    
    emit(CardCustomizationLoaded(initialCustomization));
  }

  void _onPickImageFromGallery(PickImageFromGallery event, Emitter<CardCustomizationState> emit) async {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoading());
      
      final result = await pickImageFromGalleryUseCase();
      
      result.fold(
        (failure) => emit(CardCustomizationError(
          'Failed to pick image from gallery',
          customization: currentState.customization,
        )),
        (imageFile) => emit(CardCustomizationLoaded(
          currentState.customization.copyWith(
            backgroundType: BackgroundType.image,
            backgroundImage: imageFile,
            clearBackgroundColor: true,
            clearBackgroundGradient: true,
          ),
        )),
      );
    }
  }

  void _onSelectPredefinedImage(SelectPredefinedImage event, Emitter<CardCustomizationState> emit) async {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoading());
      
      final result = await getPredefinedImage();
      
      result.fold(
        (failure) => emit(CardCustomizationError(
          'Failed to load predefined image',
          customization: currentState.customization,
        )),
        (imageFile) {
          if (imageFile != null) {
            emit(CardCustomizationLoaded(
              currentState.customization.copyWith(
                backgroundType: BackgroundType.image,
                backgroundImage: imageFile,
                clearBackgroundColor: true,
                clearBackgroundGradient: true,
              ),
            ));
          } else {
            emit(CardCustomizationError(
              'No predefined images available',
              customization: currentState.customization,
            ));
          }
        },
      );
    }
  }

  void _onSetBackgroundColor(SetBackgroundColor event, Emitter<CardCustomizationState> emit) {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoaded(
        currentState.customization.copyWith(
          backgroundType: BackgroundType.color,
          backgroundColor: event.color,
          clearBackgroundGradient: true,
          clearBackgroundImage: true,
        ),
      ));
    }
  }

  void _onSetBackgroundGradient(SetBackgroundGradient event, Emitter<CardCustomizationState> emit) {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoaded(
        currentState.customization.copyWith(
          backgroundType: BackgroundType.gradient,
          backgroundGradient: event.gradient,
          clearBackgroundColor: true,
          clearBackgroundImage: true,
        ),
      ));
    }
  }

  void _onUpdateImageScale(UpdateImageScale event, Emitter<CardCustomizationState> emit) {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoaded(
        currentState.customization.copyWith(imageScale: event.scale),
      ));
    }
  }

  void _onUpdateImagePosition(UpdateImagePosition event, Emitter<CardCustomizationState> emit) {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoaded(
        currentState.customization.copyWith(imagePosition: event.position),
      ));
    }
  }

  void _onUpdateBlurAmount(UpdateBlurAmount event, Emitter<CardCustomizationState> emit) {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationLoaded(
        currentState.customization.copyWith(blurAmount: event.blurAmount),
      ));
    }
  }

  void _onSaveCard(SaveCard event, Emitter<CardCustomizationState> emit) async {
    if (state is CardCustomizationLoaded) {
      final currentState = state as CardCustomizationLoaded;
      emit(CardCustomizationSaving(currentState.customization));
      
      final result = await saveCardCustomization(currentState.customization);
      
      result.fold(
        (failure) => emit(CardCustomizationError(
          'Failed to save card customization',
          customization: currentState.customization,
        )),
        (_) => emit(CardCustomizationSaved(currentState.customization)),
      );
    }
  }
}
