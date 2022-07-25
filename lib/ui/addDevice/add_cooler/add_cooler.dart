import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';

class AddCoolerBottomSheet extends StatelessWidget {
  const AddCoolerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialTextController = TextEditingController();
    final TextEditingController brandTextController = TextEditingController();
    final TextEditingController nameTextController = TextEditingController();
    final TextEditingController categoryTextController =
        TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListHandlerView(),
        const SizedBox(
          height: 25,
        ),
        const ChiscoText(
          text: 'افزودن کنترلر کولر جدید',
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 20,
        ),
        ChiscoTextField(
          controller: serialTextController,
          hintText: 'مانند Ch-32145267469',
          icon: 'assets/images/serial_icon.png',
          label: "شماره سریال",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: brandTextController,
          hintText: 'سامسونگ - b78s8',
          icon: 'assets/images/brand_icon.png',
          label: "برند و مدل کولر",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: nameTextController,
          hintText: 'مانند کولر اتاق پذیرایی',
          icon: 'assets/images/device_icon.png',
          label: "اسم نمایشی کنترلر: ",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: categoryTextController,
          hintText: 'مانند اتاق مهمان',
          icon: 'assets/images/category_icon.png',
          label: "دسته‌بندی:",
        ),
        const SizedBox(
          height: 20,
        ),


        ChiscoButton(
          text: 'تایید و افزودن دستگاه',
          onClick: () {},
          icon: '',
          hasIcon: false,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
