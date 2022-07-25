import 'package:chisco/ui/main/theme.dart';
import 'package:chisco/ui/profile/widgets/profile_header.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController birthController = TextEditingController();


    return SafeArea(

        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(delegate: ProfileHeader()),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff2884D6), Color(0xff1D68BB)])),
              child: Container(
                decoration: const BoxDecoration(
                    color: Styles.backGroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: 25,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25,bottom: 15),
                    child: ChiscoText(text: 'اطلاعات حساب'),
                  ),
                  ChiscoTextField(
                    controller: nameController,
                    label: 'نام و نام خانوادگی',
                    icon: 'assets/images/user.png',
                    hintText: 'مثلا مهدی ابوالحسنی',
                    hasLabel: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //todo Ask Ali For Hint Text Style
                  ChiscoTextField(
                    controller: numberController,
                    label: 'شماره تماس',
                    icon: 'assets/images/phone_icon.png',
                    hintText: '+989012345678',
                    hasLabel: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const ChiscoText(text: 'اطلاعات فردی (دلخواه)'),
                  const SizedBox(height: 20),
                  ChiscoTextField(
                    controller: locationController,
                    label: 'محل سکونت',
                    icon: 'assets/images/location.png',
                    hintText: ' فارس شیراز',
                    hasLabel: true,
                  ),
                  const SizedBox(height: 20),
                  ChiscoTextField(
                    controller: birthController,
                    label: 'تاریخ تولد',
                    icon: 'assets/images/cake.png',
                    hintText: '1370/03/19',
                    hasLabel: true,
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: ChiscoButton(
                            text: 'ثبت و ذخیره اطلاعات',
                            onClick: () {
                              //todo OnClick For Btn
                            },
                            hasIcon: false,
                            icon: '',
                          ),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
