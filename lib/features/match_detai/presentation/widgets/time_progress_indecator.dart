// widgets/match_timer_indicator.dart
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class MatchTimerIndicator extends StatelessWidget {
  final double progress;
  final String timeText;

  const MatchTimerIndicator({
    super.key,
    required this.progress,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: SizeConfig.heightMultiplier*9,
          width: SizeConfig.widthMultiplier*18,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: SizeConfig.widthMultiplier*1.5,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
          ),
        ),
        Text(
          timeText,
          style:  TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.textMultiplier*2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
