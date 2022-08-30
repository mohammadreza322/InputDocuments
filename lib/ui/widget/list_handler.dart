import 'package:chisco/utils/theme.dart';
import 'package:flutter/material.dart';

class ListHandlerView extends StatelessWidget {
  const ListHandlerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(

          decoration: BoxDecoration(
              color: Styles.primaryTextColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(5),
          ),

          margin: const EdgeInsets.only(top: 15,bottom: 10),
          width: 28,
          height: 4,
        ));
  }
}
