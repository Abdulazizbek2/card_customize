import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum BackgroundType { color, gradient, image }

class CardCustomization extends Equatable {
  final BackgroundType backgroundType;
  final Color? backgroundColor;
  final LinearGradient? backgroundGradient;
  final File? backgroundImage;
  final double blurAmount;
  final double imageScale;
  final Offset imagePosition;

  const CardCustomization({
    required this.backgroundType,
    this.backgroundColor,
    this.backgroundGradient,
    this.backgroundImage,
    required this.blurAmount,
    required this.imageScale,
    required this.imagePosition,
  });

  CardCustomization copyWith({
    BackgroundType? backgroundType,
    Color? backgroundColor,
    LinearGradient? backgroundGradient,
    File? backgroundImage,
    double? blurAmount,
    double? imageScale,
    Offset? imagePosition,
    bool clearBackgroundImage = false,
    bool clearBackgroundColor = false,
    bool clearBackgroundGradient = false,
  }) {
    return CardCustomization(
      backgroundType: backgroundType ?? this.backgroundType,
      backgroundColor: clearBackgroundColor ? null : (backgroundColor ?? this.backgroundColor),
      backgroundGradient: clearBackgroundGradient ? null : (backgroundGradient ?? this.backgroundGradient),
      backgroundImage: clearBackgroundImage ? null : (backgroundImage ?? this.backgroundImage),
      blurAmount: blurAmount ?? this.blurAmount,
      imageScale: imageScale ?? this.imageScale,
      imagePosition: imagePosition ?? this.imagePosition,
    );
  }

  @override
  List<Object?> get props => [
        backgroundType,
        backgroundColor,
        backgroundGradient,
        backgroundImage,
        blurAmount,
        imageScale,
        imagePosition,
      ];
}
