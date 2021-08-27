import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';

class ShimmerPhotoWidget extends StatelessWidget {
  const ShimmerPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: AppColors.stroke,
        highlightColor: AppColors.input,
        child: SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.stroke,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
