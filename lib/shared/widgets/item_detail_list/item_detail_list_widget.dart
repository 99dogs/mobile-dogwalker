import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';

class ItemDetailWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String info;
  const ItemDetailWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Icon(icon),
              ),
            ),
            Text.rich(
              TextSpan(
                text: label + "\n",
                style: TextStyles.input,
                children: [
                  TextSpan(
                    text: info,
                    style: TextStyles.buttonGray,
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.stroke,
        ),
      ],
    );
  }
}
