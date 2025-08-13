import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/card_customization.dart';

class CardCustomizationModel extends CardCustomization {
  const CardCustomizationModel({
    required BackgroundType backgroundType,
    Color? backgroundColor,
    LinearGradient? backgroundGradient,
    File? backgroundImage,
    required double blurAmount,
    required double imageScale,
    required Offset imagePosition,
  }) : super(
          backgroundType: backgroundType,
          backgroundColor: backgroundColor,
          backgroundGradient: backgroundGradient,
          backgroundImage: backgroundImage,
          blurAmount: blurAmount,
          imageScale: imageScale,
          imagePosition: imagePosition,
        );

  factory CardCustomizationModel.fromEntity(CardCustomization entity) {
    return CardCustomizationModel(
      backgroundType: entity.backgroundType,
      backgroundColor: entity.backgroundColor,
      backgroundGradient: entity.backgroundGradient,
      backgroundImage: entity.backgroundImage,
      blurAmount: entity.blurAmount,
      imageScale: entity.imageScale,
      imagePosition: entity.imagePosition,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'background_type': backgroundType.toString().split('.').last,
      'background_color': backgroundColor?.value.toRadixString(16),
      'background_gradient_colors': backgroundGradient?.colors.map((c) => c.value.toRadixString(16)).toList(),
      'background_gradient_begin': backgroundGradient != null && backgroundGradient!.begin is Alignment ? '${(backgroundGradient!.begin as Alignment).x},${(backgroundGradient!.begin as Alignment).y}' : null,
      'background_gradient_end': backgroundGradient != null && backgroundGradient!.end is Alignment ? '${(backgroundGradient!.end as Alignment).x},${(backgroundGradient!.end as Alignment).y}' : null,
      'blur_amount': blurAmount,
      'image_scale': imageScale,
      'image_position': '${imagePosition.dx},${imagePosition.dy}',
    };
  }
}
