import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color? color;

  StarRatingWidget({this.starCount = 5, this.rating = .0, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    double size = 18;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: size,
        color: Colors.amber,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: size,
        color: color ?? Colors.amber,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: size,
        color: color ?? Colors.amber,
      );
    }
    return new InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
