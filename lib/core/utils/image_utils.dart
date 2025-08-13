import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> compressImage(File file, {int quality = 70}) async {
    // Для упрощения просто возвращаем оригинальный файл
    // В реальном приложении здесь была бы логика сжатия
    return file;
  }

  static Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<File?> getRandomPredefinedImage() async {
    try {
      // Создаем простое градиентное изображение
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final size = const Size(300, 180);
      
      final colors = [
        [Colors.blue, Colors.purple],
        [Colors.red, Colors.orange], 
        [Colors.green, Colors.teal],
        [Colors.pink, Colors.deepPurple],
      ];
      
      final random = Random();
      final colorPair = colors[random.nextInt(colors.length)];
      
      final gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colorPair,
      );
      
      final paint = Paint()
        ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
      
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      
      final picture = recorder.endRecording();
      final img = await picture.toImage(size.width.toInt(), size.height.toInt());
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/predefined_${DateTime.now().millisecondsSinceEpoch}.png');
        await file.writeAsBytes(byteData.buffer.asUint8List());
        return file;
      }
      
      return null;
    } catch (e) {
      print('Error creating predefined image: $e');
      return null;
    }
  }
}
