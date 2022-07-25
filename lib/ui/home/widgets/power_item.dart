import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';

class PowerListItem extends StatelessWidget {
  final String powerItem;
  final String powerDescription;
  final bool isEven;
  const PowerListItem({Key? key, required this.powerItem, required this.powerDescription, required this.isEven}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthInFigma =155;
    double heightInFigma =126;

    EdgeInsets margin =
    isEven ? const EdgeInsets.only(right: 20) : const EdgeInsets.only(left: 20);
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
    return Container(
      height: 126,
      width: 155,
      margin: margin,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Styles.primaryColor.withOpacity(0.07),
              offset: Offset(0, 5),
              blurRadius: 15)
        ],


      ),
      child:  AspectRatio(
        aspectRatio: 0.81,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Styles.backGroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: (ChiscoConverter.calculateWidgetWidth(
                      constraints, widthInFigma, 40)),
                  height: (ChiscoConverter.calculateWidgetHeight(
                      constraints,heightInFigma, 40)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 11),
                  child: Image.asset(
                    'assets/images/power_icon_primary_color.png',
                    width: 24,
                    height: 18,
                  )),
              SizedBox(
                height:
                ChiscoConverter.calculateWidgetHeight(constraints, heightInFigma, 16),
              ),
              ChiscoText(
                text: powerItem,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height:
                ChiscoConverter.calculateWidgetHeight(constraints, heightInFigma, 3),
              ),
              ChiscoText(
                text: powerDescription,
                fontWeight: FontWeight.w400,
                textColor: Styles.secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );

    },



    );
  }
}
