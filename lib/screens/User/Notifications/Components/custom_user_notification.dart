import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomUserNotification extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  final String svgIcon;
  const CustomUserNotification(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.time,
      required this.svgIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(6)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Theme.of(context).colorScheme.onPrimary),
              color: Theme.of(context).colorScheme.onPrimary),
          child: SvgPicture.asset(
            svgIcon,
            color: Theme.of(context).colorScheme.primary,
            width: 32,
            height: 32,
          ),
        ),
        title: Text(title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(subTitle,
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.secondary)),
        trailing: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(height: 2)
          ],
        ),
      ),
    );
  }
}
