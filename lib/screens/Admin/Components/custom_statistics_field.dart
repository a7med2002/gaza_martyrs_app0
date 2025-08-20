import 'package:flutter/material.dart';

class CustomStatisticsField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const CustomStatisticsField(
      {super.key, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(
          labelText,
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6)),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        )
      ],
    );
  }
}
