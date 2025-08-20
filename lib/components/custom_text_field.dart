import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String svgSuffixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool isSecure;
  final Function(String)? onChanged;
  final bool? readOnly;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.svgSuffixIcon,
      required this.controller,
      required this.validator,
      required this.isSecure,
      this.onChanged,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isSecure,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              svgSuffixIcon,
              width: 30,
              height: 30,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(6))),
    );
  }
}
