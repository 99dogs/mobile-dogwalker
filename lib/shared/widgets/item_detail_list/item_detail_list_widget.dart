import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';

class ItemDetailWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String info;
  final bool enableToggleDetail;
  final void Function()? onTap;
  const ItemDetailWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.info,
    this.enableToggleDetail = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Visibility(
              visible: enableToggleDetail,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: Icon(Icons.pageview_outlined),
                    onTap: onTap,
                  ),
                ),
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
