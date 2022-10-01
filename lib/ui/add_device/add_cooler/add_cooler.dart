import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
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
    final TextEditingController categoryTextController = TextEditingController();
    ///we use [HomeController] because it's in Home Screen
    final HomeController controller = HomeController(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListHandlerView(),
          const SizedBox(
            height: 10,
          ),
          const ChiscoText(
            text: 'افزودن کنترلر کولر جدید',
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
              controller: serialTextController,
              hintText: 'مانند Ch-32145267469',
              icon: SERIAL,
              label: "شماره سریال"),
          const SizedBox(
            height: 15,
          ),
          ChiscoTextField(
            controller: brandTextController,
            hintText: 'مانند سامسونگ - b78s8',
            icon: BRAND,
            label: "برند و مدل کولر:",
          ),
          const SizedBox(
            height: 15,
          ),
          ChiscoTextField(
            controller: nameTextController,
            hintText: 'مانند کولر اتاق پذیرایی',
            icon: DEVICE,
            label: "اسم نمایشی کنترلر: ",
          ),
          const SizedBox(
            height: 15,
          ),
          ChiscoTextField(
            controller: categoryTextController,
            hintText: 'مانند اتاق مهمان',
            icon: CATEGORY,
            label: "دسته‌بندی:",
          ),
          const SizedBox(
            height:15,
          ),
          ChiscoButton(
            text: 'تایید و افزودن دستگاه',
            onClick: () async {

               controller.addCoolerBtnClicked(AddCooler(
                  brand: brandTextController.text,
                  category: categoryTextController.text,
                  model: brandTextController.text,
                  name: nameTextController.text,
                  serialNumber: serialTextController.text));
            },
            icon: '',
            hasIcon: false,
          ),

        ],
      ),
    );
  }
}
