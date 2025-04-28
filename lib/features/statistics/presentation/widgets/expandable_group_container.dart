import 'package:flutter/material.dart';
import '../../../../core/utils/size_config.dart';

class ExpandableGroupContainer extends StatelessWidget {
  final String groupName;
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Widget> children;
  final int initiallyVisibleCount;

  const ExpandableGroupContainer({
    super.key,
    required this.groupName,
    required this.isExpanded,
    required this.onTap,
    required this.children,
    this.initiallyVisibleCount = 2,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final visibleChildren = isExpanded ? children : children.take(initiallyVisibleCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier*2,top: SizeConfig.heightMultiplier*1.5,bottom: SizeConfig.heightMultiplier*0.5),
          child: Text(
            title,
            style:  TextStyle(fontSize: SizeConfig.textMultiplier*2, fontWeight: FontWeight.bold,color: Colors.deepPurple),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1.5),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 4),
          ),
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2,
                  horizontal: SizeConfig.widthMultiplier * 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RANKING DE JUGADORES',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.textMultiplier * 2,
                      ),
                    ),
                    Text(
                      'Goles',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.textMultiplier * 2,
                      ),
                    ),
                  ],
                ),
              ),
              ...visibleChildren,
              children.length>initiallyVisibleCount?InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 0.2),
                  child: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.deepPurple,
                    size: SizeConfig.imageSizeMultiplier * 8,
                  ),
                ),
              ):Padding(padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1.5),)
            ],
          ),
        ),
      ],
    );
  }
}
