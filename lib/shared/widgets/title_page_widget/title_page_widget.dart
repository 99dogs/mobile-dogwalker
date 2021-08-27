import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';

class TitlePageWidget extends StatelessWidget {
  final String title;
  final bool enableBackButton;
  final String routePage;
  final Object? args;
  const TitlePageWidget({
    Key? key,
    required this.title,
    this.enableBackButton = false,
    this.routePage = "/home",
    this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: AppColors.primary,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    enableBackButton
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                routePage,
                                arguments: args,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: Icon(Icons.arrow_back),
                            ),
                          )
                        : Container(),
                    Text(
                      title,
                      style: TextStyles.titleBoldHeading,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(),
          ),
        ],
      ),
    );
  }
}
