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

class TextfieldPass extends StatefulWidget {
  TextfieldPass(
    //this.isPassword,
    this.needSaffixIcon,
    this.inputTypes,
    this.textControl,
  );

  final bool needSaffixIcon;
  final TextInputType inputTypes;
  final TextEditingController textControl;

  @override
  State<TextfieldPass> createState() => _TextfieldPassState();
}

class _TextfieldPassState extends State<TextfieldPass> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textControl,
      style: const TextStyle(
        fontSize: 22,
      ),
      obscureText: isPassword,
      keyboardType: widget.inputTypes,
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
          visible: widget.needSaffixIcon,
          child: InkWell(
            onTap: () {
              setState(() {
                isPassword = !isPassword;
              });
            },
            child: Icon(
              isPassword ? Icons.visibility : Icons.visibility_off,
              color: AppColor.appMainColor,
            ),
          ),
        ),
      ),
    );
  }
}

//------------------------------------------

class Textfields extends StatelessWidget {
  Textfields(
    this.inputTypes,
    this.textControl,
  );
  final TextInputType inputTypes;
  final TextEditingController textControl;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textControl,
      style: const TextStyle(
        fontSize: 22,
      ),
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
      ),
    );
  }
}
