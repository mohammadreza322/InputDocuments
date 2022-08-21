import 'package:chisco/ui/devices/edit/edit_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPowerBottomSheet extends StatelessWidget {
  const EditPowerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    EditDeviceController controller = EditDeviceController(context);

    final TextEditingController serialTextController = TextEditingController();
    final TextEditingController brandTextController = TextEditingController();
    //final TextEditingController nameTextController = TextEditingController();
    final TextEditingController categoryTextController =
        TextEditingController();
    final TextEditingController powerOutletFirst = TextEditingController();
    final TextEditingController powerOutletSecond = TextEditingController();
    final TextEditingController powerOutletThird = TextEditingController();
    final TextEditingController powerOutletFourth = TextEditingController();
    final TextEditingController usbPortFirst = TextEditingController();
    final TextEditingController usbPortSecond = TextEditingController();
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
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
          ChiscoTextField(
            controller: serialTextController,
            hintText: 'مانند Ch-32145267469',
            icon: SERIAL,
            label: "شماره سریال:",
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: brandTextController,
            icon: DEVICE,
            label: "اسم نمایشی سه راهی:",
            hintText: '',
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: categoryTextController,
            hintText: '',
            icon: CATEGORY,
            label: "دسته‌بندی:",
          ),
          Theme(
            data: theme,
            child: ExpansionTile(
                collapsedIconColor: Styles.primaryColor,
                iconColor: Styles.primaryColor,
                title: const ChiscoText(
                    text: 'اسم نمایشی پریز ها پورت ها(دلخواه)'),
                children: [
                  ChiscoTextField(
                    controller: powerOutletFirst,
                    hintText: ' مانند پریز چراغ مطالعه',
                    icon: PORT,
                    label: "پریز 1:",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChiscoTextField(
                    controller: powerOutletSecond,
                    hintText: ' مانند پریز تلوزیون',
                    icon: PORT,
                    label: "پریز 2:",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChiscoTextField(
                    controller: powerOutletThird,
                    hintText: 'مانند پریز گرمکن لیوان',
                    icon: PORT,
                    label: "پریز 3:",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChiscoTextField(
                    controller: powerOutletFourth,
                    hintText: 'مانند پریز مودم و روتر',
                    icon: PORT,
                    label: "پریز 4:",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChiscoTextField(
                    controller: usbPortFirst,
                    hintText: 'مانند یو‌اس‌بی هدفون',
                    icon: USB,
                    label: "پورت 1:",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChiscoTextField(
                    controller: usbPortSecond,
                    hintText: 'مانند یو‌اس‌بی ساعت',
                    icon: USB,
                    label: "پورت 2:",
                  ),
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    print("delete  power clicked");
                  },
                  child: Container(
                    height: ChiscoConverter.calculateWidgetWidth(
                        width, buttonHeight),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [Styles.getBoxShadow(0.07)],
                        gradient: const LinearGradient(
                            colors: [Color(0xffD92249), Color(0xffCC2045)])),
                    child: Center(child: SvgPicture.asset(TRASH)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: ChiscoButton(
                  text: 'تایید و ثبت تغییرات',
                  onClick: () {
                    print('edit power clicked');
                  },
                  icon: '',
                  hasIcon: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
