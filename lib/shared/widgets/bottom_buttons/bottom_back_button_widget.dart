import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/label_button/label_button_widget.dart';

class BottomBackButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BottomBackButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 57,
      child: AnimatedCard(
        direction: AnimatedCardDirection.bottom,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke,
            ),
            Container(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: LabelButton(
                      label: label,
                      onPressed: onPressed,
                      style: TextStyles.buttonPrimary,
                    ),
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
