import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class ControlsWidget extends StatelessWidget {
  final double scale;
  final double blurAmount;
  final Function(double) onScaleChanged;
  final Function(double) onBlurChanged;
  final VoidCallback onSave;
  final bool isSaving;

  const ControlsWidget({
    Key? key,
    required this.scale,
    required this.blurAmount,
    required this.onScaleChanged,
    required this.onBlurChanged,
    required this.onSave,
    this.isSaving = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scale control
        Text(
          'Image Scale: ${scale.toStringAsFixed(1)}x',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Slider(
          value: scale,
          min: AppConstants.minScale,
          max: AppConstants.maxScale,
          divisions: 22,
          onChanged: onScaleChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
        
        const SizedBox(height: 16),
        
        // Blur control
        Text(
          'Blur Amount: ${blurAmount.toStringAsFixed(1)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Slider(
          value: blurAmount,
          min: AppConstants.minBlur,
          max: AppConstants.maxBlur,
          divisions: 100,
          onChanged: onBlurChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
        
        const SizedBox(height: 24),
        
        // Save button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isSaving ? null : onSave,
            icon: isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.save),
            label: Text(isSaving ? 'Saving...' : 'Save Card'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
