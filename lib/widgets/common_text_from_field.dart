import 'package:flutter/material.dart';
import 'package:lingoganda_news/constants/app_colors.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField(
      {super.key,
      required this.textFormFieldController,
      required this.labelName,
      required this.prefixIcon,
      this.keyboardType,
      required this.emptyMessage,
      this.validationMessage,
      this.textFieldValidateExpression});

  final TextEditingController textFormFieldController;
  final String labelName;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final String emptyMessage;
  final String? validationMessage;
  final String? textFieldValidateExpression;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFormFieldController,
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor,
        focusColor: AppColors.whiteColor,
        filled: true,
        labelText: labelName,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        prefixIcon: Icon(prefixIcon),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyMessage;
        } else if ((validationMessage != null &&
                textFieldValidateExpression != null) &&
            !RegExp(textFieldValidateExpression!).hasMatch(value)) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}
