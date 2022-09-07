import 'package:flutter/material.dart';
import '../const.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData? iconData;
  final Function(String val)? onChanged;

  const MyTextFormField(
    this.textEditingController,
    this.hintText, {
    this.iconData,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: primaryColor,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
