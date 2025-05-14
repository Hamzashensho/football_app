import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 2 * SizeConfig.textMultiplier,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class NotificationToggle extends StatefulWidget {
  final String title;

  const NotificationToggle({super.key, required this.title});

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      value: isActive,
      onChanged: (value) {
        setState(() {
          isActive = value;
        });
      },
      activeColor: Colors.teal,
    );
  }
}

class AccountOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDanger;

  const AccountOption({super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isDanger ? const Color(0xFF9C0101) : Colors.teal),
      title: Text(
        title,
        style: TextStyle(
          color: isDanger ? const Color(0xFF9C0101) : Colors.teal,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
