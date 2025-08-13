part of 'card_customization_bloc.dart';

abstract class CardCustomizationState extends Equatable {
  const CardCustomizationState();

  @override
  List<Object?> get props => [];
}

class CardCustomizationInitial extends CardCustomizationState {}

class CardCustomizationLoading extends CardCustomizationState {}

class CardCustomizationLoaded extends CardCustomizationState {
  final CardCustomization customization;

  const CardCustomizationLoaded(this.customization);

  @override
  List<Object> get props => [customization];
}

class CardCustomizationSaving extends CardCustomizationState {
  final CardCustomization customization;

  const CardCustomizationSaving(this.customization);

  @override
  List<Object> get props => [customization];
}

class CardCustomizationSaved extends CardCustomizationState {
  final CardCustomization customization;

  const CardCustomizationSaved(this.customization);

  @override
  List<Object> get props => [customization];
}

class CardCustomizationError extends CardCustomizationState {
  final String message;
  final CardCustomization? customization;

  const CardCustomizationError(this.message, {this.customization});

  @override
  List<Object?> get props => [message, customization];
}
