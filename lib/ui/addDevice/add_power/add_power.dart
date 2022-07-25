import 'package:flutter/material.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';

class AddPowerBottomSheet extends StatelessWidget {
  const AddPowerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialTextController = TextEditingController();
    final TextEditingController brandTextController = TextEditingController();
    //final TextEditingController nameTextController = TextEditingController();
    final TextEditingController categoryTextController = TextEditingController();
    final TextEditingController powerOutletFirst = TextEditingController();
    final TextEditingController powerOutletSecond = TextEditingController();
    final TextEditingController powerOutletThird = TextEditingController();
    final TextEditingController powerOutletFourth = TextEditingController();
    final TextEditingController usbPortFirst = TextEditingController();
    final TextEditingController usbPortSecond = TextEditingController();
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
          height: 15,
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
          controller: categoryTextController,
          hintText: 'مانند اتاق مهمان',
          icon: 'assets/images/category_icon.png',
          label: "دسته‌بندی:",
        ),
        const SizedBox(
          height: 25,
        ),
        const ChiscoText(text: 'اسم نمایشی پریز ها پورت ها(دلخواه)'),
        const SizedBox(
          height: 15,
        ),

        ChiscoTextField(
          controller: powerOutletFirst,
          hintText: ' مانند پریز چراغ مطالعه',
          icon: 'assets/images/category_icon.png',
          label: "پریز 1:",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: powerOutletSecond,
          hintText: ' مانند پریز تلوزیون',
          icon: 'assets/images/category_icon.png',
          label: "پریز 2:",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: powerOutletThird,
          hintText: 'مانند پریز گرمکن لیوان',
          icon: 'assets/images/category_icon.png',
          label: "پریز 3:",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: powerOutletFourth,
          hintText: 'مانند پریز مودم و روتر',
          icon: 'assets/images/category_icon.png',
          label: "پریز 4:",
        ),
        const SizedBox(
          height: 15,
        ),
        ChiscoTextField(
          controller: usbPortFirst,
          hintText: 'مانند یو‌اس‌بی هدفون',
          icon: 'assets/images/category_icon.png',
          label: "پورت 1:",
        ),
        const SizedBox(
          height:15,
        ),
        ChiscoTextField(
          controller: usbPortSecond,
          hintText: 'مانند یو‌اس‌بی ساعت',
          icon: 'assets/images/category_icon.png',
          label: "پورت 2:",
        ),
        const SizedBox(
          height: 15,
        ),

        ChiscoButton(text: 'تایید و افزودن دستگاه', onClick: (){}, icon: '',hasIcon: false,)
        ,const SizedBox(height: 20,)
        ],
    );
  }
}
