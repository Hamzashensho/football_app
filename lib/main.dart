import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/routing/route_observer.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/routing/router.dart';
import 'package:sport_app_user/core/utils/theme.dart';
import 'package:sport_app_user/features/mobile/account/presentation/screens/splash_screen.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/pages/champion_management_page.dart';
import 'package:sport_app_user/features/web/dashboard/presentation/pages/dashboard_overview_page.dart';
import 'package:sport_app_user/features/web/match_event_management/data/datasources/remote/mock_match_event_datasource.dart';
import 'package:sport_app_user/features/web/match_event_management/data/repositories/match_event_repository_impl.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/get_match_events_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/presentation/blocs/match_event_bloc.dart';
import 'package:sport_app_user/features/web/match_event_management/presentation/pages/match_event_management_page.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/pages/match_management_page.dart';
import 'package:sport_app_user/features/web/notification_management/data/datasources/remote/mock_notification_datasource.dart';
import 'package:sport_app_user/features/web/notification_management/data/repositories/notification_repository_impl.dart';
import 'package:sport_app_user/features/web/notification_management/domain/usecases/get_notifications_usecase.dart';
import 'package:sport_app_user/features/web/notification_management/presentation/blocs/notification_bloc.dart';
import 'package:sport_app_user/features/web/notification_management/presentation/pages/notification_management_page.dart';
import 'package:sport_app_user/features/web/player_management/presentation/blocs/player_bloc.dart';
import 'package:sport_app_user/features/web/player_management/presentation/pages/player_management_page.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';
import 'package:sport_app_user/features/web/team_management/presentation/pages/team_management_page.dart';
import 'package:sport_app_user/features/web/user_management/presentation/blocs/user_bloc.dart';
import 'package:sport_app_user/features/web/user_management/presentation/pages/user_management_page.dart';
import 'package:sport_app_user/injection_container.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBQnnqmOtCKDxID-0OGmfT_GTrFDI4guwo',
        appId: '1:705898564069:web:165f89755ac214e722870c',
        messagingSenderId: '705898564069',
        projectId: 'futzone-2b282',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MyRouteObserver myRouteObserver = MyRouteObserver();

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create:
              (context) => sl<UserBloc>(),
        ),
        BlocProvider<TeamBloc>(
          create:
              (context) => sl<TeamBloc>(),
        ),
        BlocProvider<PlayerBloc>(
          create:
              (context) => sl<PlayerBloc>(),
        ),
        BlocProvider<MatchBloc>(
          create:
              (context) => sl<MatchBloc>(),
        ),
        BlocProvider<MatchEventBloc>(
          create:
              (context) => MatchEventBloc(
                getMatchEventsUseCase: GetMatchEventsUseCase(
                  MatchEventRepositoryImpl(
                    mockMatchEventDataSource: MockMatchEventDataSource(),
                  ),
                ),
              ),
        ),
        BlocProvider<ChampionBloc>(
          create:
              (context) => sl<ChampionBloc>(),
        ),
        BlocProvider<NotificationBloc>(
          create:
              (context) => NotificationBloc(
                getNotificationsUseCase: GetNotificationsUseCase(
                  NotificationRepositoryImpl(
                    mockNotificationDataSource: MockNotificationDataSource(),
                  ),
                ),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [myRouteObserver],
        initialRoute: RoutePaths.splashScreen,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        routes: {
          '/users': (context) => const UserManagementPage(),
          '/teams': (context) => const TeamManagementPage(),
          '/players': (context) => const PlayerManagementPage(),
          '/matches': (context) => const MatchManagementPage(),
          '/match-events':
              (context) => const MatchEventManagementPage(matchId: 'match1'),
          '/champions': (context) => const ChampionManagementPage(),
          '/notifications': (context) => const NotificationManagementPage(),
        },
        theme: AppTheme.lightTheme,
        home: kIsWeb ? const AdminDashboardLayout() : const SplashScreen(),
      ),
    );
  }
}

class AdminDashboardLayout extends StatefulWidget {
  const AdminDashboardLayout({super.key});

  @override
  State<AdminDashboardLayout> createState() => _AdminDashboardLayoutState();
}

class _AdminDashboardLayoutState extends State<AdminDashboardLayout>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 1000;
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                extended: isWide,
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onItemTapped,
                labelType:
                    isWide
                        ? NavigationRailLabelType.none
                        : NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.dashboard),
                    label: Text('Dashboard'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.people),
                    label: Text('Users'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.groups),
                    label: Text('Teams'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.sports_soccer),
                    label: Text('Players'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.sports),
                    label: Text('Matches'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.emoji_events),
                    label: Text('Champions'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.notifications),
                    label: Text('Notifications'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: _buildSelectedPage()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return DashboardOverviewPage(onNavigate: _onItemTapped);
      case 1:
        return const UserManagementPage();
      case 2:
        return const TeamManagementPage();
      case 3:
        return const PlayerManagementPage();
      case 4:
        return const MatchManagementPage();
      case 5:
        return const ChampionManagementPage();
      case 6:
        return const NotificationManagementPage();
      default:
        return DashboardOverviewPage(onNavigate: _onItemTapped);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
