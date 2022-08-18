import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiscoIcon extends StatelessWidget {
  final String svgIcon;
  final BoxFit fit= BoxFit.cover;
  final double width;
  final double height;
  const ChiscoIcon({Key? key, required this.svgIcon, fit, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svgIcon,fit: fit,width: width,height: height,);
  }
}
