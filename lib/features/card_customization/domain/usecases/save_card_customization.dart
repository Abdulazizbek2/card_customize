import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/card_customization.dart';
import '../repositories/card_customization_repository.dart';

class SaveCardCustomization {
  final CardCustomizationRepository repository;

  SaveCardCustomization(this.repository);

  Future<Either<Failure, void>> call(CardCustomization customization) async {
    return await repository.saveCardCustomization(customization);
  }
}
