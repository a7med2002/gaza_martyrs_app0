import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color txtColor;
  final Color btnColor;
  final bool withIcon;
  final String svgicon;
  final Color svgColor;
  final VoidCallback onTap;
  final double fontSize;
  const CustomButton(
      {super.key,
      required this.text,
      required this.txtColor,
      required this.btnColor,
      required this.withIcon,
      this.svgicon = '',
      required this.onTap,
      required this.fontSize,
      this.svgColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: withIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svgicon,
                    width: 24,
                    height: 24,
                    color: svgColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(color: txtColor, fontSize: fontSize),
                  )
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: txtColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
