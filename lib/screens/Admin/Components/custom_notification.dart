import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNotification extends StatelessWidget {
  final String title;
  final String subTitle;
  final String svgIcon;
  final String dateTime;
  const CustomNotification(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.svgIcon,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(6)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer),
              color: Colors.transparent),
          child: SvgPicture.asset(
            svgIcon,
            color: Theme.of(context).colorScheme.primary,
            width: 24,
            height: 24,
          ),
        ),
        title: Text(title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        subtitle: Text(subTitle,
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.secondary)),
        trailing: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              dateTime,
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.secondary),
            ),
            CircleAvatar(
                radius: 7,
                backgroundColor: Theme.of(context).colorScheme.primary)
          ],
        ),
      ),
    );
  }
}
