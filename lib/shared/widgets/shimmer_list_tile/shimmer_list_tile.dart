import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';

class ShimmerListTileWidget extends StatelessWidget {
  const ShimmerListTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double containerWidth = size.width - 100;
    double containerHeight = 20;

    return Container(
      child: Shimmer.fromColors(
        baseColor: AppColors.stroke,
        highlightColor: AppColors.input,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.5),
          child: Column(
            children: [
              Row(
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
                        width: containerWidth * 0.70,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: containerHeight * 0.80,
                        width: containerWidth * 0.45,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 48,
                      width: 90,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Container(
                  width: size.width,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.stroke,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
