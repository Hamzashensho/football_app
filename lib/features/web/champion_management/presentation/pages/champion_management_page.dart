import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/champion_management/data/datasources/remote/remote_champion_datasource.dart';
import 'package:sport_app_user/features/web/champion_management/data/repositories/champion_repository_impl.dart';
import 'package:sport_app_user/features/web/champion_management/domain/usecases/get_champions_usecase.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';


class ChampionManagementPage extends StatefulWidget {
  const ChampionManagementPage({super.key});

  @override
  State<ChampionManagementPage> createState() => _ChampionManagementPageState();
}

class _ChampionManagementPageState extends State<ChampionManagementPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChampionBloc(
        getChampionsUseCase: GetChampionsUseCase(
          ChampionRepositoryImpl(
            mockChampionDataSource: ChampionRemoteDataSourceImpl(),
          ),
        ),
      ),      child: Scaffold(
        appBar: AppBar(
          title: const Text('Champion Management'),
        ),
        body: BlocBuilder<ChampionBloc, ChampionState>(
          builder: (context, state) {
            if (state is ChampionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ChampionLoaded) {
              if (state.champions.isEmpty) {
                return const Center(child: Text('No champions found.'));
              }
              return ListView.builder(
                itemCount: state.champions.length,
                itemBuilder: (context, index) {
                  final champion = state.champions[index];
                  return ListTile(
                    title: Text(champion.title),
                    subtitle: Text('Date: ${champion.date.toIso8601String()
                        .substring(0, 10)}'),
                    // Add more details and actions (edit, delete) here
                  );
                },
              );
            }
            if (state is ChampionError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Champion Management Page - Initial State'),
                    ElevatedButton(
                        onPressed: () {
                          context.read<ChampionBloc>().add(LoadChampions());
                        },
                        child: const Text('Load Champions (Test)')
                    )
                  ],
                )
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to add champion page or show a dialog
          },
          tooltip: 'Add Champion',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

