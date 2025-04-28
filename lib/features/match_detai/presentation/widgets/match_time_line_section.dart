// widgets/match_timeline_section.dart
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'match_event_item.dart';

class MatchTimelineSection extends StatelessWidget {
  final String title;
  final List<MatchEventItem> events;

  const MatchTimelineSection({
    super.key,
    required this.title,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.heightMultiplier*2),
        Text(title, style:  TextStyle(color: Colors.pink, fontSize: SizeConfig.textMultiplier*2, fontWeight: FontWeight.bold)),
        SizedBox(height: SizeConfig.heightMultiplier*1.3),
        ...events,
      ],
    );
  }
}
