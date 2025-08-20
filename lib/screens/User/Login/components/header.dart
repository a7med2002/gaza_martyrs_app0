import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final String text;
  const Header({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            "assets/svgs/Arrow.svg",
            color: Theme.of(context).colorScheme.primary,
            width: 24,
            height: 24,
          ),
        ),
        SizedBox(
            width: text.contains(' ')
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width / 3),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )
      ],
    );
  }
}
