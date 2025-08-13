import 'dart:io';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/error/exceptions.dart';
import '../models/card_customization_model.dart';

abstract class CardRemoteDataSource {
  Future<void> saveCardCustomization(CardCustomizationModel customization);
  Future<File> pickImageFromGallery();
  Future<File?> getPredefinedImage();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final ApiClient apiClient;

  CardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<void> saveCardCustomization(CardCustomizationModel customization) async {
    try {
      File? compressedImage;
      if (customization.backgroundImage != null) {
        compressedImage = await ImageUtils.compressImage(customization.backgroundImage!);
      }

      final response = await apiClient.uploadCardData(
        data: customization.toJson(),
        imageFile: compressedImage,
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<File> pickImageFromGallery() async {
    try {
      final file = await ImageUtils.pickImageFromGallery();
      if (file == null) {
        throw ImageException();
      }
      return file;
    } catch (e) {
      throw ImageException();
    }
  }

  @override
  Future<File?> getPredefinedImage() async {
    try {
      return await ImageUtils.getRandomPredefinedImage();
    } catch (e) {
      throw ImageException();
    }
  }
}
