import 'package:get_it/get_it.dart';
import 'features/card_customization/data/datasources/card_remote_data_source.dart';
import 'features/card_customization/data/repositories/card_customization_repository_impl.dart';
import 'features/card_customization/domain/repositories/card_customization_repository.dart';
import 'features/card_customization/domain/usecases/save_card_customization.dart';
import 'features/card_customization/domain/usecases/pick_image_from_gallery.dart' as pick_image_usecase;
import 'features/card_customization/domain/usecases/get_predefined_image.dart';
import 'features/card_customization/presentation/bloc/card_customization_bloc.dart';
import 'core/network/api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Card Customization
  // Bloc
  sl.registerFactory(
    () => CardCustomizationBloc(
      saveCardCustomization: sl(),
      pickImageFromGalleryUseCase: sl(),
      getPredefinedImage: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SaveCardCustomization(sl()));
  sl.registerLazySingleton(() => pick_image_usecase.PickImageFromGallery(sl()));
  sl.registerLazySingleton(() => GetPredefinedImage(sl()));

  // Repository
  sl.registerLazySingleton<CardCustomizationRepository>(
    () => CardCustomizationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CardRemoteDataSource>(
    () => CardRemoteDataSourceImpl(apiClient: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => ApiClient());

  //! External
}
