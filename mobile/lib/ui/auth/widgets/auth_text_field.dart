import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;

  final TextEditingController controller;
  final String text;
  final String icon;
  final bool isInputNumber;
  const AuthTextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.text,
      required this.icon, required this.isInputNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChiscoText(
          text: label,
          textColor: Styles.primaryTextColor,
        ),
        const SizedBox(
          height: 10,
        ),
        ChiscoTextField(controller: controller, hintText: text, icon: icon,hasLabel: false,isInputNumber: isInputNumber,)
      ],
    );
  }
}
