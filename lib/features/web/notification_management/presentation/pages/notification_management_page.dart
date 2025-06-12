import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/notification_management/presentation/blocs/notification_bloc.dart';


class NotificationManagementPage extends StatefulWidget {
  const NotificationManagementPage({super.key});

  @override
  State<NotificationManagementPage> createState() => _NotificationManagementPageState();
}

class _NotificationManagementPageState extends State<NotificationManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Management'),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('No notifications found.'));
            }
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return ListTile(
                  title: Text(notification.title ?? 'Notification ID: ${notification.notificationId}'),
                  subtitle: Text('${notification.message} - ${notification.type.toString().split(".").last} on ${notification.datetime.toIso8601String().substring(0,10)}'),
                  // Add more details and actions (edit, delete) here
                );
              },
            );
          }
          if (state is NotificationError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Notification Management Page - Initial State'),
                ElevatedButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(LoadNotifications());
                  },
                  child: const Text('Load Notifications (Test)')
                )
              ],
            )
          ); // Initial or unhandled state
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add notification page or show a dialog
        },
        tooltip: 'Add Notification',
        child: const Icon(Icons.add),
      ),
    );
  }
}

