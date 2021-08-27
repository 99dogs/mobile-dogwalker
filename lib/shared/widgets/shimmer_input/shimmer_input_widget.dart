import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';

class ShimmerInputWidget extends StatelessWidget {
  const ShimmerInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 100;
    double containerHeight = 20;

    return Container(
      child: Shimmer.fromColors(
        baseColor: AppColors.stroke,
        highlightColor: AppColors.input,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: containerHeight,
                    width: containerWidth,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: containerHeight,
                    width: containerWidth,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
