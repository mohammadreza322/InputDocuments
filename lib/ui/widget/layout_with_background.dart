import 'package:flutter/material.dart';
//TODO Talk TO Ali For Create Full Blue Page Background
class BlueLayout extends StatelessWidget {
  final Widget childWidget;

  const BlueLayout({Key? key, required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home_header.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: childWidget,
        )));
  }
}
