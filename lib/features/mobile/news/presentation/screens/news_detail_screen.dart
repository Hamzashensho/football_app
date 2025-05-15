import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final DateTime dateTime;
   const NewsDetailsScreen({super.key, required this.image, required this.title, required this.description, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('h:mm a').format(dateTime);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.heightMultiplier * 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    color: Colors.black,
                  ),
                ),
                Text(

                  formattedTime,
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: SizeConfig.heightMultiplier * 1),
          const Divider(thickness: 1, color: Colors.teal),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.heightMultiplier * 2),

                    Text(
                      title,
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 2),


                    Text(
                      description,
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 2),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Visit web site:\n',
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2,
                              color: Colors.pink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: 'www.futzone.com/offers/sport',
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
