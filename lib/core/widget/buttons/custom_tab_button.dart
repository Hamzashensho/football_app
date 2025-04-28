import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class CustomTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabButton({super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 5,
              vertical: SizeConfig.heightMultiplier * 1.5,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.teal : Colors.grey,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSelected ? SizeConfig.heightMultiplier * 0.3 : 0,
            width: SizeConfig.widthMultiplier * 20,
            color: isSelected ? Colors.teal : Colors.transparent,
          ),
        ],
      ),
    );
  }
}