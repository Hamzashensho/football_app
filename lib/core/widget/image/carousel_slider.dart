import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';



class CarouselWithDots extends StatefulWidget {
  final List<String> imageList;

  const CarouselWithDots({super.key, required this.imageList});

  @override
  State<CarouselWithDots> createState() => _CarouselWithDotsState();
}

class _CarouselWithDotsState extends State<CarouselWithDots> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: SizeConfig.heightMultiplier * 20,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.imageList.map((imagePath) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier * 1.8),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
            );
          }).toList(),
        ),
        Positioned(
          bottom: SizeConfig.heightMultiplier*1.3,
          right: SizeConfig.widthMultiplier*1.8,
          child: Row(
            children: List.generate(widget.imageList.length, (index) {
              return Container(
                margin:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*0.5),
                width:_currentIndex==index?SizeConfig.widthMultiplier*5.5: SizeConfig.widthMultiplier*2.4,
                height: SizeConfig.heightMultiplier*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier*2),
                  color: _currentIndex == index ? Colors.white : Colors.white54,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

