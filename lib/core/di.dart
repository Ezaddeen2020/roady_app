import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fdelux_source_neytrip/common/blocs/auth/auth_bloc.dart';
import 'package:fdelux_source_neytrip/core/platform/geocoding_info.dart';
import 'package:fdelux_source_neytrip/core/platform/network_info.dart';
import 'package:fdelux_source_neytrip/data/data_sources/local/saved_destination_local_data_source.dart';
import 'package:fdelux_source_neytrip/data/data_sources/local/session_local_data_source.dart';
import 'package:fdelux_source_neytrip/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:fdelux_source_neytrip/data/data_sources/remote/destination_remote_data_source.dart';
import 'package:fdelux_source_neytrip/data/repositories/auth_repository.dart';
import 'package:fdelux_source_neytrip/data/repositories/destination_repository.dart';
import 'package:fdelux_source_neytrip/data/repositories/saved_destination_repository.dart';
import 'package:fdelux_source_neytrip/presentation/home/bloc/popular_destination_bloc.dart';
import 'package:fdelux_source_neytrip/presentation/saved_destinations/bloc/saved_destinations_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit/BLoC
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => PopularDestinationBloc(destinationRepository: sl()));
  sl.registerFactory(() => SavedDestinationsBloc(repository: sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<DestinationRepository>(
    () => DestinationRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<SavedDestinationRepository>(
    () => SavedDestinationRepositoryImpl(localDataSource: sl()),
  );

  /// Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<SessionLocalDataSource>(
    () => SessionLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<DestinationRemoteDataSource>(
    () => DestinationRemoteDataSourceImpl(
      client: sl(),
      sessionLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SavedDestinationLocalDataSource>(
    () => SavedDestinationLocalDataSourceImpl(sharedPreferences: sl()),
  );

  /// Platforms
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );
  sl.registerLazySingleton<GeocodingInfo>(
    () => GeocodingInfoImpl(networkInfo: sl()),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
