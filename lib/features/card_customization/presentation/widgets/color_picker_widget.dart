import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../../core/constants/app_constants.dart';

class ColorPickerWidget extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorChanged;
  final VoidCallback onGradientPressed;

  const ColorPickerWidget({
    Key? key,
    required this.selectedColor,
    required this.onColorChanged,
    required this.onGradientPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Background Color',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        
        // Predefined colors
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.predefinedColors.map((color) {
            final isSelected = color.value == selectedColor.value;
            return GestureDetector(
              onTap: () => onColorChanged(color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
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
        
        const SizedBox(height: 16),
        
        // Action buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showColorPicker(context),
                icon: const Icon(Icons.palette),
                label: const Text('Custom Color'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onGradientPressed,
                icon: const Icon(Icons.gradient),
                label: const Text('Gradients'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = selectedColor;
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) => tempColor = color,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onColorChanged(tempColor);
                Navigator.of(context).pop();
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }
}
