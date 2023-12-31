import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiscoTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final String label;
  final bool hasLabel;
  final bool isInputNumber;

  ChiscoTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.hasLabel = true,
    this.isInputNumber = false,
    this.label = '',
  }) : super(key: key);

  @override
  State<ChiscoTextField> createState() => _ChiscoTextFieldState();
}

class _ChiscoTextFieldState extends State<ChiscoTextField> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: ChiscoConverter.calculateWidgetWidth(width, buttonHeight),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Styles.primaryColor.withOpacity(0.07),
              offset: Offset(0, 4),
              blurRadius: 15,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(widget.icon),
            const SizedBox(
              width: 10,
            ),
            ChiscoText(
              text: widget.label,
              fontSize: Styles.defaultFontSize,
              fontWeight: FontWeight.w400,
            ),
            widget.hasLabel
                ? const SizedBox(
              width: 4,
            )
                : Container(),
            Flexible(
              child: TextField(
                onTap: () {
                  if (widget.controller.selection ==
                      TextSelection.fromPosition(TextPosition(
                          offset: widget.controller.text.length - 1),)) {
                    setState(() {
                      widget.controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: widget.controller.text.length),);
                    },);
                  }
                },
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                controller: widget.controller,
                keyboardType: widget.isInputNumber
                    ? TextInputType.phone
                    : TextInputType.text,
                style: const TextStyle(
                    color: Styles.primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      fontFamily: 'ChiscoText',
                      fontWeight: FontWeight.w400,
                      color: Styles.secondaryTextColor,
                      fontSize: Styles.defaultFontSize,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
