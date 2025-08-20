import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Image.asset("assets/cover/cover.png", fit: BoxFit.cover));
  }
}
