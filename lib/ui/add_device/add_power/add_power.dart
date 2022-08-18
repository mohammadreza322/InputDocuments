import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/utils/const.dart';
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
    final TextEditingController nameTextController = TextEditingController();
    final TextEditingController categoryTextController = TextEditingController();
    final TextEditingController powerOutletFirst = TextEditingController();
    final TextEditingController powerOutletSecond = TextEditingController();
    final TextEditingController powerOutletThird = TextEditingController();
    final TextEditingController powerOutletFourth = TextEditingController();
    final TextEditingController usbPortFirst = TextEditingController();
    final TextEditingController usbPortSecond = TextEditingController();
    final HomeController controller = HomeController(context);

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
            text: 'افزودن سه راهی جدید',
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: serialTextController,
            hintText: 'مانند Ch-32145267469',
            icon: SERIAL,
            label: "شماره سریال",
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: nameTextController,
            hintText: 'مانند سه راهی پذیرایی',
            icon: DEVICE,
            label: "اسم نمایشی سه راهی:",
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
          ExpansionTile(
          //todo Select Background color
            title: ChiscoText(text: 'اسم نمایشی پریز ها پورت ها(دلخواه)'),
            children: [
              ChiscoTextField(
                controller: powerOutletFirst,
                hintText: ' مانند پریز چراغ مطالعه',
                icon: PORT,
                label: "پریز 1:",
              ),
              const SizedBox(
                height: 10,
              ),
              ChiscoTextField(
                controller: powerOutletSecond,
                hintText: ' مانند پریز تلوزیون',
                icon: PORT,
                label: "پریز 2:",
              ),
              const SizedBox(
                height: 10,
              ),
              ChiscoTextField(
                controller: powerOutletThird,
                hintText: 'مانند پریز گرمکن لیوان',
                icon: PORT,
                label: "پریز 3:",
              ),
              const SizedBox(
                height: 10,
              ),
              ChiscoTextField(
                controller: powerOutletFourth,
                hintText: 'مانند پریز مودم و روتر',
                icon: PORT,
                label: "پریز 4:",
              ),
              const SizedBox(
                height: 10,
              ),
              ChiscoTextField(
                controller: usbPortFirst,
                hintText: 'مانند یو‌اس‌بی هدفون',
                icon: USB,
                label: "پورت 1:",
              ),
              const SizedBox(
                height: 10,
              ),
              ChiscoTextField(
                controller: usbPortSecond,
                hintText: 'مانند یو‌اس‌بی ساعت',
                icon: USB,
                label: "پورت 2:",
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoButton(
            text: 'تایید و افزودن دستگاه',
            onClick: () {
              controller.addPowerBtnClicked(AddPower(
                  category: categoryTextController.text,
                  name: nameTextController.text,
                  power1: powerOutletFirst.text,
                  power2: powerOutletSecond.text,
                  power3: powerOutletThird.text,
                  power4: powerOutletFourth.text,
                  serialNumber: serialTextController.text,
                  usb1: usbPortFirst.text,
                  usb2: usbPortSecond.text));
            },
            icon: '',
            hasIcon: false,
          )
        ],
      ),
    );
  }
}
