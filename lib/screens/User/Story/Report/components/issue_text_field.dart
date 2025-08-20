import 'package:flutter/material.dart';
import 'package:get/utils.dart';

// ignore: must_be_immutable
class IssueTextField extends StatelessWidget {
  TextEditingController issueDescController = TextEditingController();
  IssueTextField({super.key, required this.issueDescController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty || value == "") {
          return "Please Write your issue".tr;
        }
        return null;
      },
      controller: issueDescController,
      maxLines: 6,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          hintText: "Write your issue here".tr,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7))),
    );
  }
}
