import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'app_properties.dart';

class Richtexts extends StatelessWidget {
  const Richtexts(
      {Key? key,
      required this.firstText,
      required this.secText,
      required this.roughtpage})
      : super(key: key);

  final String firstText;
  final String secText;
  final VoidCallback roughtpage;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: AppTextStyle.smallTextStyle.copyWith(fontSize: 16),
          ),
          TextSpan(
              text: secText,
              style: AppTextStyle.smallTextStyle
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              recognizer: TapGestureRecognizer()..onTap = roughtpage),
        ],
      ),
    );
  }
}
