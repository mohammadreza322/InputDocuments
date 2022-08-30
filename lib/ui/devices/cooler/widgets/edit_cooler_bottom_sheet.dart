import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/EditCoolerRequest.dart';
import 'package:chisco/ui/devices/edit/edit_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/const.dart';
import 'package:chisco/utils/converter.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_button.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/ui/widget/chisco_textfield.dart';
import 'package:chisco/ui/widget/chisco_unchange_textfield.dart';
import 'package:chisco/ui/widget/list_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditCoolerBottomSheet extends StatelessWidget {
  final Cooler selectedCooler;

  const EditCoolerBottomSheet({Key? key, required this.selectedCooler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditDeviceController controller = EditDeviceController(context);
    final TextEditingController serialTextController = TextEditingController();
    final TextEditingController nameTextController = TextEditingController(
        text: selectedCooler.name);
    final TextEditingController categoryTextController = TextEditingController(
        text: selectedCooler.category);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

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
            text: 'ویرایش اطلاعات دستگاه',
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 10,
          ),

          ChiscoFixedTextField(
            text: selectedCooler.serialNumber,
            icon: SERIAL,
            label: "شماره سریال",
          ),
          const SizedBox(
            height: 10,
          ),

          ChiscoFixedTextField(icon: BRAND, label: 'بزند و مدل کولر:', text: selectedCooler.brand),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: nameTextController,
            hintText: selectedCooler.name,
            icon: DEVICE,
            label: "اسم نمایشی کنترلر: ",
          ),
          const SizedBox(
            height: 10,
          ),
          ChiscoTextField(
            controller: categoryTextController,
            hintText: selectedCooler.category,
            icon: CATEGORY,
            label: "دسته‌بندی:",
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    print("delete clicked");
                      controller.onDeviceDeleteClicked(selectedCooler.serialNumber);
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
                            colors: [ Color(0xffD92249), Color(0xffCC2045)])),
                    child: Center(
                        child: SvgPicture.asset(TRASH)
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 5,
                child: ChiscoButton(
                  text: 'تایید و ثبت تغییرات',
                  onClick: () {
                    print('edit Cooler clicked');

                    controller.onCoolerEditClicked(EditCooler(
                      brand: selectedCooler.brand,
                        model: selectedCooler.model,
                        category:categoryTextController.text,
                        name: nameTextController.text,
                        serialNumber: selectedCooler.serialNumber));
                  },
                  icon: '',
                  hasIcon: false,
                ),
              ),
            ],),


        ],
      ),
    );
  }
}
