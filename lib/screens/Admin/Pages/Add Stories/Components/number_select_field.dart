import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class NumberSelectField extends StatelessWidget {
  final String hintTxt;
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChange;

  const NumberSelectField(
      {super.key,
      required this.hintTxt,
      required this.min,
      required this.max,
      required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SpinBox(
      min: min,
      max: max,
      value: value,
      textStyle: TextStyle(fontSize: 14),
      incrementIcon: Icon(Icons.add, size: 18),
      decrementIcon: Icon(Icons.remove, size: 18),
      decoration: InputDecoration(
        hintText: hintTxt,
        hintStyle: TextStyle(fontSize: 14),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
      ),
      onChanged: onChange,
    );
  }
}
