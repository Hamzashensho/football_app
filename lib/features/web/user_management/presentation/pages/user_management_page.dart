import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/user_management/presentation/blocs/user_bloc.dart';


class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  void initState() {
    super.initState();
     context.read<UserBloc>().add(LoadUsers());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        buildWhen: (previous, current) => current is UserLoaded,
        listener: (BuildContext context, UserState state) {
          if(state is UserLoading){
            LoadingOverlay.of(context).show();
          }else if(state is UserLoaded){
            LoadingOverlay.of(context).hide();
          }else if(state is UserError){
            LoadingOverlay.of(context).hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No users found.'));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  // Add more details and actions (edit, delete) here
                );
              },
            );
          }
          if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('User Management Page - Initial State'),
                ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LoadUsers());
                  },
                  child: const Text('Load Users (Test)')
                )
              ],
            )
          ); // Initial or unhandled state
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add user page or show a dialog
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}

