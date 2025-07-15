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
import 'package:sport_app_user/features/web/champion_management/data/datasources/remote/remote_champion_datasource.dart';
import 'package:sport_app_user/features/web/champion_management/data/repositories/champion_repository_impl.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/add_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/delete_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/edit_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/get_champions_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';
import 'package:sport_app_user/features/web/match_management/data/datasources/remote/remote_match_datasource.dart';
import 'package:sport_app_user/features/web/match_management/data/repositories/match_repository_impl.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/add_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/delete_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/edit_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/get_matches_usecase.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/team_management/data/datasources/remote/team_remote_datasource.dart';
import 'package:sport_app_user/features/web/team_management/data/repositories/team_repository_impl.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/add_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/delete_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/edit_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/get_teams_usecase.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

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
      () => AuthRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<SharedPrefsService>()),
    )
    ..registerLazySingleton<ChampionRemoteDataSource>(
      ChampionRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<TeamRemoteDataSource>(TeamRemoteDataSourceImpl.new)
    ..registerLazySingleton<RemoteMatchDataSource>(
      RemoteMatchDataSourceImpl.new,
    );

  // Repository
  sl
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
    )
    ..registerLazySingleton<ChampionRepository>(
      () => ChampionRepositoryImpl(mockChampionDataSource: sl()),
    )
    ..registerLazySingleton<TeamRepository>(
      () => TeamRepositoryImpl(mockTeamDataSource: sl()),
    )
    ..registerLazySingleton<MatchRepository>(
      () => MatchRepositoryImpl(remoteMatchDataSource: sl()),
    );

  // Use Cases
  sl
    ..registerLazySingleton(() => SignInWithEmail(sl()))
    ..registerLazySingleton(() => SignUpWithEmail(sl()))
    ..registerLazySingleton(() => SignInWithFacebook(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => GetCurrentUser(sl()))
    ..registerLazySingleton(() => AddChampionUseCase(sl()))
    ..registerLazySingleton(() => GetChampionsUseCase(sl()))
    ..registerLazySingleton(() => DeleteChampionUseCase(sl()))
    ..registerLazySingleton(() => EditChampionUseCase(sl()))
    ..registerLazySingleton(() => GetTeamsUseCase(sl()))
    ..registerLazySingleton(() => AddTeamUseCase(sl()))
    ..registerLazySingleton(() => EditTeamUseCase(sl()))
    ..registerLazySingleton(() => DeleteTeamUseCase(sl()))
    ..registerLazySingleton(() => GetMatchesUseCase(sl()))
    ..registerLazySingleton(() => AddMatchUseCase(sl()))
    ..registerLazySingleton(() => EditMatchUseCase(sl()))
    ..registerLazySingleton(() => DeleteMatchUseCase(sl()));

  // Bloc
  sl
    ..registerFactory(AuthBloc.new)
    ..registerFactory(ChampionBloc.new)
    ..registerLazySingleton(TeamBloc.new)
    ..registerLazySingleton(MatchBloc.new);
}
