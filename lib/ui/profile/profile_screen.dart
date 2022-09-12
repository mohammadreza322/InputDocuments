import 'dart:async';
import 'dart:math';

import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/ui/account/account_controller.dart';
import 'package:chisco/ui/profile/profile_controller.dart';
import 'package:chisco/ui/widget/chisco_time_text_view.dart';
import 'package:chisco/ui/widget/chisco_unchange_textfield.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';

import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Provider.of<ProfileController>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (!controller.isPageLoading) {
      print('init');
      controller.init();
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: ChiscoConverter.calculateWidgetHeight(height, 260),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(APP_HEADER_BACKGROUND_IMAGE),
                          fit: BoxFit.cover)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ChiscoAppbar(
                        icon: ARROW_RIGHT,
                        iconAlignment: Alignment.centerRight,
                        title: 'ویرایش اطلاعات کاربری',
                        onClick: () {
                          FocusScope.of(context).unfocus();
                          Timer(const Duration(milliseconds: 5), () {
                            Navigator.pop(context);
                          });
                        }),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(
                  top: ChiscoConverter.calculateWidgetHeight(height, 70)),
              padding: EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Styles.backGroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 15),
                    child: ChiscoText(
                      text: 'اطلاعات حساب',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ChiscoTextField(
                    controller: controller.nameController,
                    label: 'نام و نام خانوادگی :',
                    icon: USER,
                    hintText: 'نام شما',
                    hasLabel: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChiscoFixedTextField(
                      icon: PHONE,
                      label: 'شماره تماس',
                      text: controller.numberController.text),
                  const SizedBox(
                    height: 25,
                  ),
                  const ChiscoText(
                    text: 'اطلاعات فردی (دلخواه)',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 10),
                  ChiscoTextField(
                    controller: controller.locationController,
                    label: 'محل سکونت :',
                    icon: LOCATION,
                    hintText: 'ندارد',
                    hasLabel: true,
                  ),
                  const SizedBox(height: 15),
                  ChiscoTimeSelector(
                      icon: CAKE,
                      label: 'تاریخ تولد:',
                      text: controller.selectedStringDate,
                      isHint: controller.isHintDate,
                      onClick: () async {
                        var picker = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1330, 10),
                            lastDate: Jalali.now());
                        if (picker != null) {
                          controller.changeSelectedDate(picker.toDateTime());
                        }
                      }),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ChiscoButton(
                            text: 'ثبت و ذخیره اطلاعات',
                            onClick: () {
                              controller.submitEditUserBtnClicked(
                                  controller.nameController.text,
                                  controller.selectedStringDate,
                                  controller.locationController.text);
                            },
                            hasIcon: false,
                            icon: '',
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
