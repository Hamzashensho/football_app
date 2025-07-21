import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';
import 'package:sport_app_user/features/web/notification_management/data/datasources/remote/mock_notification_datasource.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/notification_management/domain/entities/notification_entity.dart';
import 'package:sport_app_user/features/web/user_management/presentation/blocs/user_bloc.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';
import 'package:sport_app_user/features/web/player_management/presentation/blocs/player_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/notification_management/presentation/blocs/notification_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardOverviewPage extends StatefulWidget {
  final Function(int)? onNavigate;
  
  const DashboardOverviewPage({
    super.key, 
    this.onNavigate,
  });

  @override
  State<DashboardOverviewPage> createState() => _DashboardOverviewPageState();
}

class _DashboardOverviewPageState extends State<DashboardOverviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsers());
    context.read<TeamBloc>().add(LoadTeams());
    context.read<PlayerBloc>().add(LoadPlayers());
    context.read<MatchBloc>().add(LoadMatches());
    context.read<ChampionBloc>().add(LoadChampions());
    context.read<NotificationBloc>().add(LoadNotifications());
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set({'fcmToken': newToken}, SetOptions(merge: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Overview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reload all data
              context.read<UserBloc>().add(LoadUsers());
              context.read<TeamBloc>().add(LoadTeams());
              context.read<PlayerBloc>().add(LoadPlayers());
              context.read<MatchBloc>().add(LoadMatches());
              context.read<NotificationBloc>().add(LoadNotifications());
            },
            tooltip: 'Refresh Data',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings or show settings dialog
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with date and welcome message
            _buildHeader(),
            
            const SizedBox(height: 24),
            
            // Key metrics cards row
            _buildKeyMetricsSection(),
            
            const SizedBox(height: 24),
            
            // Charts section
            _buildChartsSection(),
            
            const SizedBox(height: 24),
            
            // Recent activity sections
            _buildRecentActivitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Admin Dashboard',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Here\'s what\'s happening today',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateTime.now().toString().substring(0, 10),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              DateTime.now().toString().substring(11, 16),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              childAspectRatio: constraints.maxWidth > 1200 ? 1.3 : (constraints.maxWidth > 800 ? 1.6 : 2),
              crossAxisCount: constraints.maxWidth > 1200 ? 4 : (constraints.maxWidth > 800 ? 2 : 1),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildUserMetricCard(),
                _buildTeamMetricCard(),
                _buildPlayerMetricCard(),
                _buildMatchMetricCard(),
              ],
            );
          }
        ),
      ],
    );
  }

  Widget _buildUserMetricCard() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        int userCount = 0;
        if (state is UserLoaded) {
          userCount = state.users.length;
        }
        
        return _buildMetricCard(
          title: 'Total Users',
          value: userCount.toString(),
          icon: Icons.people,
          color: Colors.blue,
          isLoading: state is UserLoading,
          onTap: () {
            // Navigate to User Management page
            if (widget.onNavigate != null) {
              widget.onNavigate!(1); // Index 1 is for Users in the navigation rail
            } else {
              Navigator.pushNamed(context, '/users');
            }
          },
        );
      },
    );
  }

  Widget _buildTeamMetricCard() {
    return BlocBuilder<TeamBloc, TeamState>(
      builder: (context, state) {
        int teamCount = 0;
        if (state is TeamLoaded) {
          teamCount = state.teams.length;
        }
        
        return _buildMetricCard(
          title: 'Total Teams',
          value: teamCount.toString(),
          icon: Icons.groups,
          color: Colors.green,
          isLoading: state is TeamLoading,
          onTap: () {
            // Navigate to Team Management page
            if (widget.onNavigate != null) {
              widget.onNavigate!(2); // Index 2 is for Teams in the navigation rail
            } else {
              Navigator.pushNamed(context, '/teams');
            }
          },
        );
      },
    );
  }

  Widget _buildPlayerMetricCard() {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        int playerCount = 0;
        if (state is PlayerLoaded) {
          playerCount = state.players.length;
        }
        
        return _buildMetricCard(
          title: 'Total Players',
          value: playerCount.toString(),
          icon: Icons.sports_soccer,
          color: Colors.orange,
          isLoading: state is PlayerLoading,
          onTap: () {
            // Navigate to Player Management page
            if (widget.onNavigate != null) {
              widget.onNavigate!(3); // Index 3 is for Players in the navigation rail
            } else {
              Navigator.pushNamed(context, '/players');
            }
          },
        );
      },
    );
  }

  Widget _buildMatchMetricCard() {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        int matchCount = 0;
        final Map<String?, int> statusCounts = {
          'Upcoming': 0,
          'Live': 0,
          'Completed': 0,
        };
        
        if (state is MatchLoaded) {
          matchCount = state.matches.length;
          for (var match in state.matches) {
            statusCounts[match.status] = (statusCounts[match.status] ?? 0) + 1;
          }
        }
        
        return _buildMetricCard(
          title: 'Total Matches',
          value: matchCount.toString(),
          icon: Icons.sports,
          color: Colors.purple,
          isLoading: state is MatchLoading,
          subtitle: 'Upcoming: ${statusCounts[MatchStatus.Upcoming]}, In Progress: ${statusCounts[MatchStatus.Live]}, Completed: ${statusCounts[MatchStatus.Completed]}',
          onTap: () {
            // Navigate to Match Management page
            if (widget.onNavigate != null) {
              widget.onNavigate!(4); // Index 4 is for Matches in the navigation rail
            } else {
              Navigator.pushNamed(context, '/matches');
            }
          },
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    bool isLoading = false,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Icon(
                          icon,
                          color: color,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                    if (onTap != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'View Details',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: color,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 800
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildMatchStatusChart()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTeamPerformanceChart()),
                    ],
                  )
                : Column(
                    children: [
                      _buildMatchStatusChart(),
                      const SizedBox(height: 16),
                      _buildTeamPerformanceChart(),
                    ],
                  );
          },
        ),
      ],
    );
  }

  Widget _buildMatchStatusChart() {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is MatchLoaded) {
          // Count matches by status
          final Map<String?, int> statusCounts = {
            'Upcoming': 0,
            'Live': 0,
            "Completed": 0,
          };
          
          for (var match in state.matches) {
            statusCounts[match.status] = (statusCounts[match.status] ?? 0) + 1;
          }
          
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () {
                // Navigate to Match Management page
                if (widget.onNavigate != null) {
                  widget.onNavigate!(4); // Index 4 is for Matches in the navigation rail
                } else {
                  Navigator.pushNamed(context, '/matches');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Match Status Distribution',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Icon(Icons.info_outline, size: 18),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: statusCounts['Upcoming']!.toDouble(),
                              title: 'Upcoming',
                              color: Colors.blue,
                              radius: 60,
                            ),
                            PieChartSectionData(
                              value: statusCounts['Live']!.toDouble(),
                              title: 'In Progress',
                              color: Colors.orange,
                              radius: 60,
                            ),
                            PieChartSectionData(
                              value: statusCounts['Completed']!.toDouble(),
                              title: 'Completed',
                              color: Colors.green,
                              radius: 60,
                            ),
                          ],
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Upcoming', Colors.blue),
                        const SizedBox(width: 16),
                        _buildLegendItem('In Progress', Colors.orange),
                        const SizedBox(width: 16),
                        _buildLegendItem('Completed', Colors.green),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View All Matches',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        
        return const SizedBox(
          height: 300,
          child: Center(child: Text('No match data available')),
        );
      },
    );
  }

  Widget _buildTeamPerformanceChart() {
    return BlocBuilder<TeamBloc, TeamState>(
      builder: (context, state) {
        if (state is TeamLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is TeamLoaded) {
          // Sort teams by goal count for the chart
          final teams = List<TeamEntity>.from(state.teams);
          teams.sort((a, b) => (b.goalCount ?? 0).compareTo(a.goalCount ?? 0));
          
          // Take top 5 teams or all if less than 5
          final topTeams = teams.take(5).toList();
          
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () {
                // Navigate to Team Management page
                if (widget.onNavigate != null) {
                  widget.onNavigate!(2); // Index 2 is for Teams in the navigation rail
                } else {
                  Navigator.pushNamed(context, '/teams');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Teams by Goals',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Icon(Icons.info_outline, size: 18),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: topTeams.isNotEmpty 
                              ? (topTeams.first.goalCount?.toDouble() ?? 0) * 1.2 
                              : 10,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(value.toInt().toString()),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= topTeams.length) {
                                    return const SizedBox.shrink();
                                  }
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      topTeams[value.toInt()].name.split(' ').first,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(

                            ),
                            topTitles: const AxisTitles(

                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: topTeams.asMap().entries.map((entry) {
                            final index = entry.key;
                            final team = entry.value;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: team.goalCount?.toDouble() ?? 0,
                                  color: Colors.green,
                                  width: 20,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View All Teams',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        
        return const SizedBox(
          height: 300,
          child: Center(child: Text('No team data available')),
        );
      },
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(title),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 1200
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildUpcomingMatchesTable()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildRecentMatchResultsTable()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildLatestNotificationsPanel()),
                    ],
                  )
                : Column(
                    children: [
                      _buildUpcomingMatchesTable(),
                      const SizedBox(height: 16),
                      _buildRecentMatchResultsTable(),
                      const SizedBox(height: 16),
                      _buildLatestNotificationsPanel(),
                    ],
                  );
          },
        ),
      ],
    );
  }

  Widget _buildUpcomingMatchesTable() {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MatchLoaded) {
          final List<MatchEntity> upcomingMatches = state.matches
              .where((match) => match.status == MatchStatus.Upcoming)
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));

          final nextMatches = upcomingMatches.take(5).toList();

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    context,
                    icon: Icons.sports_soccer,
                    title: "Upcoming Matches",
                    onViewAll: () {
                      widget.onNavigate?.call(4) ?? Navigator.pushNamed(context, '/matches');
                    },
                  ),
                  const SizedBox(height: 16),
                  if (nextMatches.isEmpty)
                    _buildEmptyState("No upcoming matches")
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nextMatches.length,
                      separatorBuilder: (_, __) => const Divider(height: 20),
                      itemBuilder: (_, index) {
                        final match = nextMatches[index];
                        return _buildMatchTile(match);
                      },
                    ),
                ],
              ),
            ),
          );
        }

        return const SizedBox(
          height: 300,
          child: Center(child: Text('No match data available')),
        );
      },
    );
  }

  Widget _buildRecentMatchResultsTable() {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is MatchLoaded) {
          // Filter and sort completed matches
          final List<MatchEntity>completedMatches = state.matches
              .where((MatchEntity match) => match.status == MatchStatus.Completed)
              .toList();
          
          completedMatches.sort((a, b) => b.date.compareTo(a.date));
          
          // Take last 5 matches
          final recentMatches = completedMatches.take(5).toList();
          
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Match Results',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to Match Management page
                          if (widget.onNavigate != null) {
                            widget.onNavigate!(4); // Index 4 is for Matches in the navigation rail
                          } else {
                            Navigator.pushNamed(context, '/matches');
                          }
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  recentMatches.isEmpty
                      ? const Center(child: Text('No recent match results'))
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentMatches.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final match = recentMatches[index];
                            return ListTile(
                              title: Text('${match.teamAId} vs ${match.teamBId}'),
                              subtitle: Text(
                                '${match.date.toString().substring(0, 10)} at ${match.stadiumName}',
                              ),
                              trailing: Text(
                                '${match.teamAScore ?? 0} - ${match.teamBScore ?? 0}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              onTap: () {
                                // Navigate to match details or match management
                                if (widget.onNavigate != null) {
                                  widget.onNavigate!(4); // Index 4 is for Matches in the navigation rail
                                } else {
                                  Navigator.pushNamed(context, '/matches');
                                }
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        }
        
        return const SizedBox(
          height: 300,
          child: Center(child: Text('No match data available')),
        );
      },
    );
  }

  Widget _buildLatestNotificationsPanel() {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (state is NotificationLoaded) {
          // Sort notifications by date (most recent first)
          final notifications = List<NotificationEntity>.from(state.notifications);
          notifications.sort((a, b) => b.datetime.compareTo(a.datetime));
          
          // Take latest 5 notifications
          final latestNotifications = notifications.take(5).toList();
          
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Notifications',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to Notification Management page
                          if (widget.onNavigate != null) {
                            widget.onNavigate!(6); // Index 6 is for Notifications in the navigation rail
                          } else {
                            Navigator.pushNamed(context, '/notifications');
                          }
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  latestNotifications.isEmpty
                      ? const Center(child: Text('No notifications'))
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: latestNotifications.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final notification = latestNotifications[index];
                            return ListTile(
                              leading: _getNotificationIcon(notification.type),
                              title: Text(notification.title ?? 'Notification'),
                              subtitle: Text(notification.message),
                              trailing: Text(
                                _formatDateTime(notification.datetime),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              onTap: () {
                                // Navigate to notification details or notification management
                                if (widget.onNavigate != null) {
                                  widget.onNavigate!(6); // Index 6 is for Notifications in the navigation rail
                                } else {
                                  Navigator.pushNamed(context, '/notifications');
                                }
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        }
        
        return const SizedBox(
          height: 300,
          child: Center(child: Text('No notification data available')),
        );
      },
    );
  }

  Widget _getNotificationIcon(NotificationType type) {
    IconData iconData;
    Color iconColor;
    
    switch (type) {
      case NotificationType.matchReminder:
        iconData = Icons.sports_soccer;
        iconColor = Colors.green;
        break;
      case NotificationType.scoreUpdate:
        iconData = Icons.scoreboard;
        iconColor = Colors.blue;
        break;
      case NotificationType.favoriteTeamNews:
        iconData = Icons.favorite;
        iconColor = Colors.red;
        break;
      case NotificationType.systemAlert:
        iconData = Icons.warning;
        iconColor = Colors.orange;
        break;
      case NotificationType.promotional:
        iconData = Icons.campaign;
        iconColor = Colors.purple;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey;
        break;
    }
    
    return CircleAvatar(
      backgroundColor: iconColor.withValues(alpha: 0.2),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
  Widget _buildSectionHeader(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: onViewAll,
          icon: const Icon(Icons.arrow_forward, size: 16),
          label: const Text('View All'),
          style: TextButton.styleFrom(foregroundColor: Colors.blue),
        ),
      ],
    );
  }
  Widget _buildMatchTile(MatchEntity match) {
    return InkWell(
      onTap: () => widget.onNavigate?.call(4) ?? Navigator.pushNamed(context, '/matches'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.blueGrey),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${match.teamAId} vs ${match.teamBId}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${match.date.toLocal().toString().split(' ')[0]} • ${match.stadiumName}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.hourglass_empty, size: 40, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text('Check back later for updates', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

}
