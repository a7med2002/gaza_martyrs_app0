import 'package:flutter/material.dart';

class CustomPopupContainer extends StatelessWidget {
  final Widget child;
  const CustomPopupContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.all(24),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
