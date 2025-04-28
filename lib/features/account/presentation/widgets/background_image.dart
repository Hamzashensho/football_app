import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagePath;
  const BackgroundImage({
    super.key,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          color: Colors.black.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
