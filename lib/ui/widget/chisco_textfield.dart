import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';

import 'package:chisco/ui/main/theme.dart';

class ChiscoTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String icon;
  final String label;
  final bool hasLabel;

  const ChiscoTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.icon,
      this.hasLabel = true,
      this.label = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * (46 / 767),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Styles.primaryColor.withOpacity(0.07),
          offset: Offset(0, 4),
          blurRadius: 15,
        )
      ]),
      child: TextField(
        controller: controller,
        
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Image.asset(icon),
            labelStyle: const TextStyle(
              fontFamily: 'ChiscoText',
              fontWeight: FontWeight.w300,
              color: Styles.primaryTextColor,
              fontSize: 16,
            ),
            labelText: (hasLabel) ? label : '',
            prefixStyle: const TextStyle(
              fontFamily: 'ChiscoText',
              fontWeight: FontWeight.w300,
              color: Styles.primaryTextColor,
              fontSize: 16,
            ),

            /* prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Image.asset(icon),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  (hasLabel) ? label : '',
                  style: const TextStyle(
                    fontFamily: 'ChiscoText',
                    fontWeight: FontWeight.w300,
                    color: Styles.primaryTextColor,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),*/
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'ChiscoText',
              fontWeight: FontWeight.w300,
              color: Styles.secondaryTextColor,
              fontSize: 16,
            )),
      ),
    );
  }
}
