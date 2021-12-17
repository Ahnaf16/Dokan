// ignore_for_file: use_key_in_widget_constructors

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
        style: AppTextStyle.smallTextStyle,
      ),
    );
  }
}

//-------------------------------------------------------------

class Textfields extends StatelessWidget {
  const Textfields(
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
    );
  }
}
