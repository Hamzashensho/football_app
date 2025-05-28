import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sport_app_user/core/services/shared_prefs_service.dart';
import 'package:sport_app_user/features/mobile/account/data/datasources/auth_local_data_source.dart';
import 'package:sport_app_user/features/mobile/account/data/datasources/auth_remote_data_source.dart';
import 'package:sport_app_user/features/mobile/account/data/repositories/auth_repository_imp.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_in_with_email.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_in_with_facebook.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_out.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/sign_up_with_email.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/get_current_user.dart';
import 'package:sport_app_user/features/mobile/account/presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core Services
  await SharedPrefsService.init();
  sl.registerSingleton<SharedPrefsService>(SharedPrefsService.instance);

  // Firebase & Third-party Services
  sl
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<GoogleSignIn>(GoogleSignIn.new)
    ..registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);

  // Data Sources
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(sl()))
    ..registerLazySingleton<AuthLocalDataSource>(
            () => AuthLocalDataSourceImpl(sl<SharedPrefsService>()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));

  // Use Cases
  sl
    ..registerLazySingleton(() => SignInWithEmail(sl()))
    ..registerLazySingleton(() => SignUpWithEmail(sl()))
    ..registerLazySingleton(() => SignInWithFacebook(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => GetCurrentUser(sl()));

  // Bloc
  sl.registerFactory(AuthBloc.new);
}
