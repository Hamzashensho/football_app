import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';

class ChampionManagementPage extends StatefulWidget {
  const ChampionManagementPage({super.key});

  @override
  State<ChampionManagementPage> createState() => _ChampionManagementPageState();
}

class _ChampionManagementPageState extends State<ChampionManagementPage> {
  List<ChampionEntity> champions = [];

  late bool reload = false;

  @override
  void initState() {
    super.initState();
    context.read<ChampionBloc>().add(LoadChampions());
  }

  void _showSnackBar(String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChampionBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Champion Management')),
      body: BlocConsumer<ChampionBloc, ChampionState>(
        buildWhen: (previous, current) => current is ChampionLoaded,
        listener: (context, state) {
          if (state is ChampionLoading||state is DeleteChampionLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is ChampionLoaded) {
            LoadingOverlay.of(context).hide();
          }else if(state is DeleteChampionSuccess){
            bloc.add(LoadChampions());
            LoadingOverlay.of(context).hide();
          } else if (state is ChampionError) {
            _showSnackBar(state.message);
          }else if(state is DeleteChampionError){
            _showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is ChampionLoaded) {
            if (state.champions.isEmpty) {
              return const Center(child: Text('No champions found.'));
            }
            champions = state.champions;
            return ListView.builder(
              itemCount: champions.length,
              itemBuilder: (context, index) {
                final champion = champions[index];

                return ListTile(
                  title: Text(champion.title),
                  subtitle: Text(
                    'Date: ${champion.date.toIso8601String().substring(0, 10)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _showAddChampionDialog(
                            context: context,
                            bloc: bloc,
                            champion: champion,
                            isEdit: true,
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          bloc.add(
                            DeleteChampion(championId: champion.championId),
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddChampionDialog(context: context, bloc: bloc);
          if (reload) {
            bloc.add(LoadChampions());
          }
        },
        tooltip: 'Add Champion',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddChampionDialog({
    required BuildContext context,
    required ChampionBloc bloc,
    ChampionEntity? champion,
    bool isEdit = false,
  }) {
    final TextEditingController titleController = TextEditingController(
      text: champion?.title,
    );
    final TextEditingController dateController = TextEditingController(
      text:
          DateFormat(
            'yyyy-MM-dd',
          ).format(champion?.date ?? DateTime.now()).toString(),
    );
    final formKey = GlobalKey<FormState>();
    showEntityDialog(
      context: context,
      title: 'Add New Champion',
      form: BlocProvider.value(
        value: bloc,
        child: BlocListener<ChampionBloc, ChampionState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is AddChampionLoading || state is EditChampionLoading) {
              LoadingOverlay.of(context).show();
            } else if (state is AddChampionSuccess ||
                state is EditChampionSuccess) {
              _showSnackBar('Success');
              Navigator.of(context).pop();
              bloc.add(LoadChampions());
            } else if (state is AddChampionError) {
              _showSnackBar(state.message);
            } else if (state is EditChampionError) {
              _showSnackBar(state.message);
            }
          },
          child: EntityForm(
            formKey: formKey,
            fields: [
              FormFieldConfig(
                name: 'Title',
                label: 'Champion Title',
                initialText: champion?.title ?? '',
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required' : null,
                controller: titleController,
              ),
              FormFieldConfig(
                name: 'Date',
                label: 'Champion Date',
                initialText: champion?.date.toString() ?? '',
                isDatePicker: true,
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required' : null,
                controller: dateController,
              ),
            ],
          ),
        ),
      ),
      onSave: () {
        if (formKey.currentState?.validate() ?? false) {
          if (!isEdit) {
            bloc.add(
              AddChampion(
                date: DateFormat('yyyy-MM-dd').parseStrict(dateController.text),
                title: titleController.text,
              ),
            );
          } else {
            if (DateTime.parse(dateController.text) != champion?.date ||
                titleController.text != champion?.title) {
              bloc.add(
                EditChampion(
                  championId: champion?.championId ?? '',
                  date: DateFormat(
                    'yyyy-MM-dd',
                  ).parseStrict(dateController.text),
                  title: titleController.text,
                ),
              );
            }
          }
          setState(() {
            reload = true;
          });
        }

      },
    );
  }
}
