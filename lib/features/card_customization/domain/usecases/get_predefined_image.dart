import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/card_customization_repository.dart';

class GetPredefinedImage {
  final CardCustomizationRepository repository;

  GetPredefinedImage(this.repository);

  Future<Either<Failure, File?>> call() async {
    return await repository.getPredefinedImage();
  }
}
