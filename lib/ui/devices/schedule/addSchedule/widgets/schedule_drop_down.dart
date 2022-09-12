import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChiscoDropDown extends StatelessWidget {
  final List<Connector> connectors;
  final Function(Object?) onDropDownChange;
  final String dropDownString;
  const ChiscoDropDown({Key? key, required this.connectors, required this.onDropDownChange, required this.dropDownString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return  DropdownButtonHideUnderline(
        child: DropdownButton2(
          items: connectors
              .map((item) => DropdownMenuItem<int>(
              value: item.connectorId,
              alignment: Alignment.centerRight,
              child: ChiscoText(
                text: item.name,
              )))
              .toList(),
          onChanged: (value) {
            print(value);
            /*int index = connectors.indexWhere(
                    (element) => element.connectorId == value);
            controller.changeDropDownValue(
                connectors[index].name, value as int);*/

            onDropDownChange(value);
          },
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16)),
          buttonHeight: buttonHeight,
          buttonDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)),
          buttonWidth: double.infinity,
          itemHeight:
          ChiscoConverter.calculateWidgetHeight(width, 64),
          itemPadding: const EdgeInsets.only(left: 14, right: 14,top: 5,bottom: 5),
          hint: Padding(
            padding: EdgeInsets.only(
                right: ChiscoConverter.calculateWidgetHeight(
                    width, 20)),
            child: Row(
              children: [
                SvgPicture.asset(DEVICE),
                const SizedBox(
                  width: 10,
                ),
                const ChiscoText(
                  fontWeight: FontWeight.w400,
                  text: 'اسم پورت یا پریز:',
                ),
                const SizedBox(
                  width: 4,
                ),
                ChiscoText(
                  text: dropDownString,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(
                left: ChiscoConverter.calculateWidgetHeight(
                    width, 20)),
            child: SvgPicture.asset(ARROW_BOTTOM),
          ),

        ));
  }
}
