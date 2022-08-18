import 'package:chisco/ui/widget/chisco_icon.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderItem extends StatelessWidget {
  final String titleText ;
  final String icon ;
  final String counterText;
  const HeaderItem({Key? key, required this.titleText, required this.icon, required this.counterText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       SvgPicture.asset(icon,color: Colors.white,),
        const SizedBox(width: 8,),
        ChiscoText(text: '$titleText: ',fontWeight: FontWeight.w400,textColor: Colors.white,),
        ChiscoText(text: counterText,fontWeight: FontWeight.w400,textColor: Colors.white,)
      ],
    );
  }
}
