import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:dogwalker/shared/widgets/label_button/label_button_widget.dart';

class BottomButtonsWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;

  const BottomButtonsWidget({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
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
                      label: primaryLabel,
                      onPressed: primaryOnPressed,
                      style:
                          enablePrimaryColor ? TextStyles.buttonPrimary : null,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.maxFinite,
                    color: AppColors.stroke,
                  ),
                  Expanded(
                    child: LabelButton(
                      label: secondaryLabel,
                      onPressed: secondaryOnPressed,
                      style: enableSecondaryColor
                          ? TextStyles.buttonPrimary
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
