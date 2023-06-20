import 'package:flutter/material.dart';
import 'package:cers/src/utils/app_const.dart';

class AppDropdownTextFormField extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final String value;
  final void Function(String?)? onChanged;

  AppDropdownTextFormField({
    required this.labelText,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: AppConst.black),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(labelText),
            isDense: true,
            onChanged: onChanged,
            items: [
              ...options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
