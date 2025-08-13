import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback onPickFromGallery;
  final VoidCallback onSelectPredefined;

  const ImagePickerWidget({
    Key? key,
    required this.onPickFromGallery,
    required this.onSelectPredefined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Background Image',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        
        // Predefined images preview
        Row(
          children: [
            ...AppConstants.predefinedImagePaths.take(3).map((path) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    image: DecorationImage(
                      image: AssetImage(path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Action buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onPickFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('From Gallery'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onSelectPredefined,
                icon: const Icon(Icons.collections),
                label: const Text('Predefined'),
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
}
