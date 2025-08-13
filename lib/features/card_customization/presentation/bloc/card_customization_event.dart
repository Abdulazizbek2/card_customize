part of 'card_customization_bloc.dart';

abstract class CardCustomizationEvent extends Equatable {
  const CardCustomizationEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCard extends CardCustomizationEvent {}

class PickImageFromGallery extends CardCustomizationEvent {}

class SelectPredefinedImage extends CardCustomizationEvent {}

class SetBackgroundColor extends CardCustomizationEvent {
  final Color color;

  const SetBackgroundColor(this.color);

  @override
  List<Object> get props => [color];
}

class SetBackgroundGradient extends CardCustomizationEvent {
  final LinearGradient gradient;

  const SetBackgroundGradient(this.gradient);

  @override
  List<Object> get props => [gradient];
}

class UpdateImageScale extends CardCustomizationEvent {
  final double scale;

  const UpdateImageScale(this.scale);

  @override
  List<Object> get props => [scale];
}

class UpdateImagePosition extends CardCustomizationEvent {
  final Offset position;

  const UpdateImagePosition(this.position);

  @override
  List<Object> get props => [position];
}

class UpdateBlurAmount extends CardCustomizationEvent {
  final double blurAmount;

  const UpdateBlurAmount(this.blurAmount);

  @override
  List<Object> get props => [blurAmount];
}

class SaveCard extends CardCustomizationEvent {}
