import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomInput extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  final String hintText;

  //Creatng a function for the onChanged and onSubmitted
  final Function(String) onChanged, onSubmitted;

  // to change the focus of the input fields
  final FocusNode focusNode;

  // changing the  textinputaction
  final TextInputAction textInputAction;

  //====== to obscure the password text
  final bool isPasswordField;

  // ignore: use_key_in_widget_constructors
  const CustomInput(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        obscureText: _isPasswordField,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'hint Text ..',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 19, vertical: 19)),
        style: Constant.regularDarkText,
      ),
    );
  }
}
