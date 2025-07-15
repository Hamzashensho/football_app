import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/widgets/match_dialog.dart';
import 'package:sport_app_user/features/web/match_management/presentation/widgets/match_list_view.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

class MatchManagementPage extends StatefulWidget {
  const MatchManagementPage({super.key});

  @override
  State<MatchManagementPage> createState() => _MatchManagementPageState();
}

class _MatchManagementPageState extends State<MatchManagementPage> {
  @override
  void initState() {
    super.initState();
    context.read<MatchBloc>().add(LoadMatches());
  }

  void _showSnackBar(String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MatchBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => bloc.add(LoadMatches()),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<MatchBloc, MatchState>(
        listener: (context, state) {
          if (state is MatchLoading || state is DeleteMatchLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is MatchLoaded || state is DeleteMatchSuccess) {
            LoadingOverlay.of(context).hide();
            if (state is DeleteMatchSuccess) bloc.add(LoadMatches());
          } else if (state is MatchError) {
            _showSnackBar(state.message);
          } else if (state is DeleteMatchFailed) {
            _showSnackBar(state.message);
          }
        },
        buildWhen:
            (previous, current) =>
                current is MatchLoaded || current is MatchError,
        builder: (context, state) {
          if (state is MatchLoaded) {
            return MatchListView(matches: state.matches);
          } else if (state is MatchError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => bloc.add(LoadMatches()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showMatchDialog(
              context: context,
              teamList: context.read<TeamBloc>().teamsList,
              championList: context.read<ChampionBloc>().championsList,
            ),
        tooltip: 'Add Match',
        child: const Icon(Icons.add),
      ),
    );
  }
}
