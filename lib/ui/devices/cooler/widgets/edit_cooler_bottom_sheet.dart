import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/chisco_unchange_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';

class EditCoolerBottomSheet extends StatelessWidget {
  const EditCoolerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialTextController = TextEditingController();
    final TextEditingController nameTextController = TextEditingController();
    final TextEditingController categoryTextController =
        TextEditingController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListHandlerView(),
          const SizedBox(
            height: 15,
          ),
          const ChiscoText(
            text: 'ویرایش اطلاعات دستگاه',
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 10,
          ),

          const ChiscoFixedTextField(
            text: 'مانند Ch-32145267469',
            icon: SERIAL,
            label: "شماره سریال",
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: nameTextController,
            hintText: 'مانند کولر اتاق پذیرایی',
            icon: DEVICE,
            label: "اسم نمایشی کنترلر: ",
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: categoryTextController,
            hintText: 'مانند اتاق مهمان',
            icon: CATEGORY,
            label: "دسته‌بندی:",
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              //todo Delete Btn Click
            },
            child: Container(
              //todo HardCode Height Of all Buttons
              height: ChiscoConverter.calculateWidgetWidth(width, buttonHeight),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [Styles.getBoxShadow(0.07)],
                  gradient: const LinearGradient(
                      colors: [Color(0xffCC2044), Color(0xffDB244B)])),
              child: const Center(
                child: ChiscoText(
                  text: 'حذف دستگاه',

                  fontWeight: FontWeight.w500,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ChiscoButton(
            text: 'ویرایش دستگاه',
            onClick: () {},
            icon: '',
            hasIcon: false,
          ),

        ],
      ),
    );
  }
}
