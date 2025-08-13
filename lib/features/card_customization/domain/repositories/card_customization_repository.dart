import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/card_customization.dart';

abstract class CardCustomizationRepository {
  Future<Either<Failure, void>> saveCardCustomization(CardCustomization customization);
  Future<Either<Failure, File>> pickImageFromGallery();
  Future<Either<Failure, File?>> getPredefinedImage();
}
