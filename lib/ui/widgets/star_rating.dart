import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final ValueChanged<double> onRatingChanged;
  final Color color;

  const StarRating(
      {Key? key,
      this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.color})
      : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 18,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: 18,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: 18,
      );
    }

    return InkResponse(
      // onTap:
      //     onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
            starCount,
            (index) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: buildStar(context, index),
                )));
  }
}
