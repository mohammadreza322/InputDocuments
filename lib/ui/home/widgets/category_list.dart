import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/utils/theme.dart';
import 'package:chisco/ui/widget/chisco_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListItem extends StatelessWidget {
  final bool isSelected;
  final String category;

  const CategoryListItem({
    Key? key,
    required this.isSelected,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("On Tap $category");
        Provider.of<HomeController>(context, listen: false)
            .filteringDevices(category);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            ChiscoText(
              textColor: isSelected
                  ? Styles.primaryColor
                  : Styles.primaryColor.withOpacity(0.5),
              text: category,
            ),
            if (isSelected)
              Center(
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                      color: Styles.primaryColor, shape: BoxShape.circle),
                ),
              )
          ],
        ),
      ),
    );
  }
}
