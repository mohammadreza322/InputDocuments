import 'package:chisco/ui/account/account_header.dart';
import 'package:chisco/ui/account/account_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_appbar.dart';
import 'package:chisco/ui/widget/chisco_icon.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AccountController accountController = Provider.of<AccountController>(context);
    if(!accountController.isLoadingPage){
      accountController.init();
    }

    List<AccountItem> items = accountController.getSettingItems();

    return SafeArea(
        child: Scaffold(
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
                child: Column(
                  children: [
                    Column(
                      children: [
                        ChiscoAppbar(
                            icon: ARROW_RIGHT,
                            iconAlignment: Alignment.centerRight,
                            title: 'حساب کاربری',
                            onClick: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          height:
                              ChiscoConverter.calculateWidgetWidth(width, 20),
                        ),
                        SvgPicture.asset(
                          PROFILE,
                          width: 68,
                          height: 68,
                        ),

                        SizedBox(
                            height: ChiscoConverter.calculateWidgetWidth(
                                width, 10)),
                        //todo User Name and Phone Number
                         ChiscoText(
                          text: accountController.userDetail!.fullName,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                            height:
                                ChiscoConverter.calculateWidgetWidth(width, 5)),

                        ChiscoText(
                          text: accountController.userDetail!.phoneNumber,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),

                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
              top: ChiscoConverter.calculateWidgetHeight(height, 220),
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Styles.backGroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      margin: const EdgeInsets.only(bottom: 8, top: 0),
                      child: const ListHandlerView(),
                    ),
                    SizedBox(
                      height: ChiscoConverter.calculateWidgetWidth(width, 4),
                    ),
                    ...items.map((AccountItem item) {
                      //Todo InkWell Gesture
                      return InkWell(
                        onTap: item.onClick,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              ChiscoConverter.calculateWidgetWidth(width, 20),
                              ChiscoConverter.calculateWidgetWidth(width, 8),
                              ChiscoConverter.calculateWidgetWidth(width, 20),
                              ChiscoConverter.calculateWidgetWidth(width, 8)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xff1d67ba)
                                              .withOpacity(0.07)),
                                      width:
                                          ChiscoConverter.calculateWidgetWidth(
                                              width, 42),
                                      height:
                                          ChiscoConverter.calculateWidgetWidth(
                                              width, 42),
                                      padding: EdgeInsets.all(
                                          ChiscoConverter.calculateWidgetWidth(
                                              width, 10)),
                                      child: SvgPicture.asset(
                                        item.icon,
                                        color: item.isRed
                                            ? Styles.redButtonBackground
                                            : Styles.primaryTextColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ChiscoText(
                                        text: item.title,
                                        fontWeight: FontWeight.w400,
                                        textColor: item.isRed
                                            ? Styles.redButtonBackground
                                            : Styles.primaryTextColor),
                                  ],
                                ),
                                item.isRed
                                    ? Container()
                                    : SvgPicture.asset(LEFT_ARROW),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ChiscoText(
                          //todo Get From Server With Some Package
                          text: 'نسخه 1.0.0 طراحی شده در ویوتک',
                          textColor: Styles.primaryTextColor.withOpacity(0.5),
                        ),
                      ),
                    ))
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
