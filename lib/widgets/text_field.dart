import 'package:employee_record/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool enabled;
  final String hintText;
  final String value;
  final String prefixIcon;
  final String? suffixIcon;
  const InputFieldWidget(
    this.textEditingController, {
    super.key,
    required this.hintText,
    this.enabled = true,
    this.value = "",
    required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.jet),
      enabled: enabled,
      textAlign: TextAlign.start,
      controller: textEditingController..text = value,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1)),
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.spanishGray,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(prefixIcon),
        ),
        suffixIcon:
            suffixIcon == null
                ? null
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(suffixIcon!),
                ),
        isDense: true, // important line
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1)),
        ),
      ),
    );
  }
}
