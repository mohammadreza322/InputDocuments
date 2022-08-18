
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../home/home_controller.dart';

import 'app_controller.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    AppController appController = Provider.of<AppController>(context);
    HomeController homeController = Provider.of<HomeController>(context);
    String selectedCategory = homeController.selectedCategory;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              width: 300,
              height: 300,
              child: SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: 50,
                appearance: CircularSliderAppearance(
                  angleRange: 180,
                    startAngle: 180,

                    customColors: CustomSliderColors(dotColor: Colors.red),
                    customWidths: CustomSliderWidths(
                        trackWidth: 40
                        ,handlerSize: 12)),
                onChange: (double value) {
                  // callback providing a value while its being changed (with a pan gesture)
                },
                onChangeStart: (double startValue) {
                  // callback providing a starting value (when a pan gesture starts)
                },
                onChangeEnd: (double endValue) {
                  // callback providing an ending value (when a pan gesture ends)
                },
                innerWidget: (double value) {
                  //This the widget that will show current value
                  return Center(
                      child: Text(
                    "${value.toInt().toString()} %",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w200),
                  ));
                },
              ),
            ),
          )),
    );
  }
}
