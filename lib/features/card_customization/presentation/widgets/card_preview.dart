import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/entities/card_customization.dart';
import '../../../../core/constants/app_constants.dart';

class CardPreview extends StatelessWidget {
  final CardCustomization customization;

  const CardPreview({
    Key? key,
    required this.customization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.cardWidth,
      height: AppConstants.cardHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius - 2),
        child: Stack(
          children: [
            // Background
            _buildBackground(),
            
            // Blur overlay
            if (customization.blurAmount > 0) _buildBlurOverlay(),
            
            // Card content
            _buildCardContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    switch (customization.backgroundType) {
      case BackgroundType.color:
        return Container(
          width: AppConstants.cardWidth,
          height: AppConstants.cardHeight,
          color: customization.backgroundColor,
        );
      
      case BackgroundType.gradient:
        return Container(
          width: AppConstants.cardWidth,
          height: AppConstants.cardHeight,
          decoration: BoxDecoration(
            gradient: customization.backgroundGradient,
          ),
        );
      
      case BackgroundType.image:
        if (customization.backgroundImage != null) {
          return Transform.translate(
            offset: customization.imagePosition,
            child: Transform.scale(
              scale: customization.imageScale,
              child: Container(
                width: AppConstants.cardWidth,
                height: AppConstants.cardHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(customization.backgroundImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }
        return Container(
          width: AppConstants.cardWidth,
          height: AppConstants.cardHeight,
          color: Colors.grey.shade200,
        );
    }
  }

  Widget _buildBlurOverlay() {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: customization.blurAmount,
        sigmaY: customization.blurAmount,
      ),
      child: Container(
        width: AppConstants.cardWidth,
        height: AppConstants.cardHeight,
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }

  Widget _buildCardContent() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card number
          Text(
            '1234 5678 9012 3456',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Cardholder and expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARD HOLDER',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'JOHN DOE',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'VALID THRU',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '12/28',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
