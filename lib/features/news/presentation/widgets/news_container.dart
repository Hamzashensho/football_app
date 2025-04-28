import 'package:flutter/material.dart';
import 'package:intl/intl.dart' ;
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class NewsContainer extends StatelessWidget {
  final String image;
  final String imageTitle;
  final String description;
  final DateTime dateTime;

  const NewsContainer({
    super.key,
    required this.image,
    required this.imageTitle,
    required this.description,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePaths.newsDetailScreen,
          arguments: {
            'image': image,
            'title': imageTitle,
            'description': description,
            'dateTime': dateTime,
          },
        );
      },
      child: Card(
        elevation: SizeConfig.imageSizeMultiplier * 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.heightMultiplier * 2),
                topRight: Radius.circular(SizeConfig.heightMultiplier * 2),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    height: SizeConfig.heightMultiplier * 25,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            // Bottom description section
            Container(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 1.2,
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(SizeConfig.heightMultiplier * 2),
                  bottomRight: Radius.circular(SizeConfig.heightMultiplier * 2),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                imageTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textMultiplier * 2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: SizeConfig.widthMultiplier * 20,
                    ),
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.6,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "See More",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: SizeConfig.textMultiplier * 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
