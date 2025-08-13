import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/card_customization_repository.dart';

class PickImageFromGallery {
  final CardCustomizationRepository repository;

  PickImageFromGallery(this.repository);

  Future<Either<Failure, File>> call() async {
    return await repository.pickImageFromGallery();
  }
}
