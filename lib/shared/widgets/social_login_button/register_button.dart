import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onTap;
  const RegisterButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.secondary),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      FontAwesomeIcons.signInAlt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Crie uma conta",
                    style: TextStyles.buttonWhite,
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
