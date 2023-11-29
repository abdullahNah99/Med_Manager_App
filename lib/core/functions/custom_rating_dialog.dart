import 'package:flutter/material.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/core/widgets/custom_button.dart';
import 'package:med_manager_app/core/widgets/space_widgets.dart';

typedef RatingAction = void Function(int value);

abstract class CustomRatingDialog {
  static void showRatingDialog(
    BuildContext context, {
    required void Function() onSubmitting,
    required RatingAction onRating,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          const VerticalSpace(2),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Rate This Doctor:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.defaultSize * 2,
              ),
            ),
          ),
          const VerticalSpace(5),
          RatingStars(onRating: onRating),
          const VerticalSpace(5),
          Center(
            child: CustomButton(
              text: 'Submit',
              onTap: onSubmitting,
            ),
          ),
        ],
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
      ),
    );
  }
}

class RatingStars extends StatefulWidget {
  final RatingAction onRating;
  const RatingStars({super.key, required this.onRating});

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  int ratingVal = 0;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: List.generate(
          5,
          (index) => TextButton(
            onPressed: () {
              setState(() {
                ratingVal = index + 1;
                widget.onRating(ratingVal);
              });
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            child: Icon(
              // RatingStars.ratingValue > index ? Icons.star : Icons.star_border,
              ratingVal > index ? Icons.star : Icons.star_border,
              color: Colors.yellow.shade700,
              size: SizeConfig.defaultSize * 5,
            ),
          ),
        ),
      ),
    );
  }
}
