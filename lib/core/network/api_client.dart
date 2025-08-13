import 'dart:io';
import 'package:http/http.dart' as http;

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

class ApiClient {
  static const String _baseUrl = 'https://your-mock-server.com';

  Future<http.Response> uploadCardData({
    required Map<String, dynamic> data,
    File? imageFile,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/upload-card'));
      
      // Добавляем поля данных
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      
      // Добавляем файл изображения, если есть
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'background_image',
            imageFile.path,
            filename: 'card_background.jpg',
          ),
        );
      }

      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception('Failed to upload card data: $e');
    }
  }
}
