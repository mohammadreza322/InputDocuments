import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:chisco/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TempController extends StatelessWidget {
  const TempController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: ChiscoText(
              text: '32°',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE8F0F9),
                        boxShadow: [
                          BoxShadow(
                              color: Styles.primaryColor.withOpacity(0.20),
                              offset: const Offset(0, 0),
                              blurRadius: 20)
                        ],
                        shape: BoxShape.circle),),
                  Center(
                    child: SleekCircularSlider(
                      min: 16,
                      max: 32,
                      initialValue: 20,

                      appearance: CircularSliderAppearance(
                        startAngle: 180,
                        angleRange: 180,
                        size: 320,
                        customWidths: CustomSliderWidths(
                          trackWidth: 20,
                          shadowWidth:0,
                          progressBarWidth: 0,
                          handlerSize: 8,

                        ),
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.transparent,
                          trackColors: const [
                            Color(0xffA04F84),
                            Color(0xff409EEB)
                          ],
                          shadowColor: const Color(0xff144FA3).withOpacity(0.25),
                          shadowMaxOpacity: 0.1,
                          shadowStep: 0.5,

                          dotColor: Colors.white,
                        ),
                      ),
                      onChange: (value) {
                        print('value ${value.toInt()}');
                      },
                      innerWidget: (percentage) {
                        return Container(
                          margin: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xff4B5196)
                                      .withOpacity(0.15)),
                              shape: BoxShape.circle),
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ChiscoText(
                                    text: '${percentage.toInt()}',
                                    fontSize: 55,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const ChiscoText(
                                    text: 'تنظیم دمای هوا',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const ChiscoText(
                                    text: 'سلسیوس',
                                    textColor: Styles.secondaryTextColor,
                                    fontWeight: FontWeight.w400,
                                  )
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ),
         const Flexible(
          fit: FlexFit.loose,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ChiscoText(
              text: '16°',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
