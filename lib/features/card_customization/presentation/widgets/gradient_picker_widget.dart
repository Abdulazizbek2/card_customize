import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class GradientPickerWidget extends StatelessWidget {
  final LinearGradient? selectedGradient;
  final Function(LinearGradient) onGradientChanged;

  const GradientPickerWidget({
    Key? key,
    this.selectedGradient,
    required this.onGradientChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Background Gradients',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        
        // Predefined gradients
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.predefinedGradients.map((gradient) {
            final isSelected = _isGradientSelected(gradient);
            return GestureDetector(
              onTap: () => onGradientChanged(gradient),
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey.shade300,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _isGradientSelected(LinearGradient gradient) {
    if (selectedGradient == null) return false;
    
    return selectedGradient!.colors.length == gradient.colors.length &&
        selectedGradient!.colors.every((color) => gradient.colors.contains(color)) &&
        selectedGradient!.begin == gradient.begin &&
        selectedGradient!.end == gradient.end;
  }
}
