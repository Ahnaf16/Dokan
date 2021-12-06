import 'package:flutter/material.dart';
import 'app_properties.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.buttonText,
    required this.gotoPage,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback gotoPage;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: gotoPage,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width / 2.3, 55),
        backgroundColor: AppColor.fillColorL,
        primary: AppColor.appMainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: const BorderSide(
          color: AppColor.appMainColor,
          width: 2,
        ),
        elevation: 0,
      ),
      child: Text(
        buttonText,
        style: AllTextStyle.bodyTextStyle,
      ),
    );
  }
}

//----------------------------------------------------