import 'package:flutter/material.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_text.dart';

class AppDropdownTextFormField extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final String value;
  final String? header;
  final void Function(String?)? onChanged;

  AppDropdownTextFormField({
    required this.header,
    required this.labelText,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null)
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              txt: header,
              size: 15,
              color: AppConst.secondary,
              weight: FontWeight.w900,
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppConst.secondary),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: AppText(
                  txt: labelText,
                  color: AppConst.secondary,
                  size: 15,
                ),
                isDense: true,
                onChanged: onChanged,
                items: [
                  ...options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: AppText(
                        txt: option,
                        size: 15,
                        color: AppConst.black,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
