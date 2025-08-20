import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String svgIcon;
  final bool hasChildren;
  final double fontSize;
  final VoidCallback onTap;
  const CustomTile(
      {super.key,
      required this.title,
      required this.svgIcon,
      required this.hasChildren,
      required this.fontSize,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.onPrimary),
          child: SvgPicture.asset(svgIcon,
              color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title),
        titleTextStyle: TextStyle(
            fontFamily: "Jali Arabic",
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: fontSize),
        trailing: SvgPicture.asset(
            hasChildren
                ? "assets/svgs/more-Arrow-Down.svg"
                : "assets/svgs/Arrow - Right 2.svg",
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
