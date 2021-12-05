import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'app_properties.dart';

class TextfieldHint extends StatelessWidget {
  const TextfieldHint({
    Key? key,
    required this.hint,
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        hint,
        style: AllTextStyle.smallTextStyle,
      ),
    );
  }
}

//-------------------------------------------------------------

class Textfields extends StatelessWidget {
  const Textfields({
    Key? key,
    required this.isPassword,
    required this.needSaffixIcon,
    required this.inputTypes,
    required this.textControl,
  }) : super(key: key);

  final bool isPassword;
  final bool needSaffixIcon;
  final TextInputType inputTypes;
  final TextEditingController textControl;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textControl,
      style: const TextStyle(
        fontSize: 22,
      ),
      obscureText: isPassword,
      keyboardType: inputTypes,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        filled: true,
        fillColor: AppColor.fillColorL,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColor.appMainColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColor.appMainColor,
            width: 2,
          ),
        ),
        suffixIcon: Visibility(
          visible: needSaffixIcon,
          child: const Icon(
            Icons.visibility,
            color: AppColor.appMainColor,
          ),
        ),
      ),
    );
  }
}

//------------------------------------------

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
            style: AllTextStyle.smallTextStyle.copyWith(fontSize: 16),
          ),
          TextSpan(
              text: secText,
              style: AllTextStyle.smallTextStyle
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              recognizer: TapGestureRecognizer()..onTap = roughtpage),
        ],
      ),
    );
  }
}
