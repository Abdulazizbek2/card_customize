import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/card_customization.dart';
import '../../domain/repositories/card_customization_repository.dart';
import '../datasources/card_remote_data_source.dart';
import '../models/card_customization_model.dart';

class CardCustomizationRepositoryImpl implements CardCustomizationRepository {
  final CardRemoteDataSource remoteDataSource;

  CardCustomizationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> saveCardCustomization(CardCustomization customization) async {
    try {
      final model = CardCustomizationModel.fromEntity(customization);
      await remoteDataSource.saveCardCustomization(model);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, File>> pickImageFromGallery() async {
    try {
      final file = await remoteDataSource.pickImageFromGallery();
      return Right(file);
    } on ImageException {
      return Left(ImageFailure());
    } catch (e) {
      return Left(ImageFailure());
    }
  }

  @override
  Future<Either<Failure, File?>> getPredefinedImage() async {
    try {
      final file = await remoteDataSource.getPredefinedImage();
      return Right(file);
    } on ImageException {
      return Left(ImageFailure());
    } catch (e) {
      return Left(ImageFailure());
    }
  }
}
