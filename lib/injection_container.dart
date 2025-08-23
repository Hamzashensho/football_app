import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:sport_app_user/features/mobile/profile/data/datasources/profile_reomte_datasource.dart';
import 'package:sport_app_user/features/mobile/profile/data/repositories/profile_repository_impl.dart';
import 'package:sport_app_user/features/mobile/profile/domain/repositories/profile_repository.dart';
import 'package:sport_app_user/features/mobile/profile/domain/usecases/edit_user_usecase.dart';
import 'package:sport_app_user/features/mobile/profile/domain/usecases/get_user_usecase.dart';
import 'package:sport_app_user/features/mobile/profile/presentation/blocs/profile_bloc.dart';
import 'package:sport_app_user/features/web/champion_management/data/datasources/remote/remote_champion_datasource.dart';
import 'package:sport_app_user/features/web/champion_management/data/repositories/champion_repository_impl.dart';
import 'package:sport_app_user/features/web/champion_management/domain/repositories/champion_repository.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/add_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/delete_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/edit_champion_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/get_champions_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';
import 'package:sport_app_user/features/web/match_event_management/data/datasources/remote/mock_match_event_datasource.dart';
import 'package:sport_app_user/features/web/match_event_management/data/repositories/match_event_repository_impl.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/repositories/match_event_repository.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/add_match_event_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/delete_match_event_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/get_match_events_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/update_match_event_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/presentation/blocs/match_event_bloc.dart';
import 'package:sport_app_user/features/web/match_management/data/datasources/remote/remote_match_datasource.dart';
import 'package:sport_app_user/features/web/match_management/data/repositories/match_repository_impl.dart';
import 'package:sport_app_user/features/web/match_management/domain/repositories/match_repository.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/add_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/delete_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/edit_match_usecase.dart';
import 'package:sport_app_user/features/web/match_management/domain/usecases/get_matches_usecase.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/player_management/data/datasources/remote/remote_player_datasource.dart';
import 'package:sport_app_user/features/web/player_management/data/repositories/player_repository_impl.dart';
import 'package:sport_app_user/features/web/player_management/domain/repositories/player_repository.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/add_player_usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/delete_player_usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/edit_player_usecase.dart';
import 'package:sport_app_user/features/web/player_management/domain/usecases/get_players_usecase.dart';
import 'package:sport_app_user/features/web/player_management/presentation/blocs/player_bloc.dart';
import 'package:sport_app_user/features/web/team_management/data/datasources/remote/team_remote_datasource.dart';
import 'package:sport_app_user/features/web/team_management/data/repositories/team_repository_impl.dart';
import 'package:sport_app_user/features/web/team_management/domain/repositories/team_repository.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/add_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/delete_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/edit_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/get_teams_usecase.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';
import 'package:sport_app_user/features/web/user_management/data/datasources/remote/mock_user_datasource.dart';
import 'package:sport_app_user/features/web/user_management/data/repositories/user_repository_impl.dart';
import 'package:sport_app_user/features/web/user_management/domain/repositories/user_repository.dart';
import 'package:sport_app_user/features/web/user_management/domain/usecases/get_users_usecase.dart';
import 'package:sport_app_user/features/web/user_management/presentation/blocs/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core Services
  await SharedPrefsService.init();
  sl.registerSingleton<SharedPrefsService>(SharedPrefsService.instance);

  // Firebase & Third-party Services
  sl
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<GoogleSignIn>(GoogleSignIn.new);
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
    )
    ..registerLazySingleton<MockPlayerDataSource>(MockPlayerDataSourceImpl.new)
    ..registerLazySingleton<MockUserDataSource>(MockUserDataSourceImpl.new)
    ..registerLazySingleton<RemoteMatchEventDataSource>(
      RemoteMatchEventDataSourceImp.new,
    )
  ..registerLazySingleton<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl.new);

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
    )
    ..registerLazySingleton<PlayerRepository>(
      () => PlayerRepositoryImpl(mockPlayerDataSource: sl()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(mockUserDataSource: sl()),
    )
    ..registerLazySingleton<MatchEventRepository>(
      () => MatchEventRepositoryImpl(remoteDataSource: sl()),
    )
  ..registerLazySingleton<ProfileRepository>(()=>ProfileRepositoryImpl(remoteDataSource: sl()));

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
    ..registerLazySingleton(() => DeleteMatchUseCase(sl()))
    ..registerLazySingleton(() => GetPlayersUseCase(sl()))
    ..registerLazySingleton(() => AddPlayerUseCase(sl()))
    ..registerLazySingleton(() => EditPlayerUseCase(sl()))
    ..registerLazySingleton(() => DeletePlayerUseCase(sl()))
    ..registerLazySingleton(() => GetUsersUseCase(sl()))
    ..registerLazySingleton(() => GetMatchEventsUseCase(sl()))
    ..registerLazySingleton(() => AddMatchEventsUseCase(sl()))
    ..registerLazySingleton(() => UpdateMatchEventsUseCase(sl()))
    ..registerLazySingleton(() => DeleteMatchEventsUseCase(sl()))
  ..registerLazySingleton(()=>EditUserUseCase(sl()))
  ..registerLazySingleton(()=>GetUserProfileUseCase(sl()));

  // Bloc
  sl
    ..registerFactory(AuthBloc.new)
    ..registerFactory(ChampionBloc.new)
    ..registerLazySingleton(TeamBloc.new)
    ..registerLazySingleton(MatchBloc.new)
    ..registerLazySingleton(PlayerBloc.new)
    ..registerLazySingleton(UserBloc.new)
    ..registerLazySingleton(MatchEventBloc.new)
  ..registerLazySingleton(ProfileBloc.new);
}
