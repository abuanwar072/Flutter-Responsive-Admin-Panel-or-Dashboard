import 'dart:ui' as ui;

import 'package:admin/config/constants.dart';
import 'package:flutter/material.dart';

mixin FieldProvider {
  Widget buildTextFormField({
    required BuildContext context,
    required String hintText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String? Function(String?)? validator,
    InputBorder? enabledBorder,
    InputBorder? filledBorder,
    bool isPasswordField = false,
    String? suffixText,
    String? errorMessage,
    ui.TextDirection? textDirection,
    isFieldReversed = false,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      cursorColor: primaryColor,
      keyboardType: keyboardType,
      obscureText: isPasswordField,
      textDirection: textDirection ??
          (isFieldReversed ? ui.TextDirection.ltr : ui.TextDirection.rtl),
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        suffixText: suffixText,
        suffixStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).hintColor.withOpacity(0.5)),
        hintText: hintText,
        fillColor: Colors.transparent,
        focusedBorder: filledBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: primaryColor,
              ),
            ),
        errorText: errorMessage,
        enabledBorder: enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).hintColor.withOpacity(0.2),
              ),
            ),
      ),
    );
  }
}
