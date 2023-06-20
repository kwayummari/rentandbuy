import 'package:flutter/material.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_text.dart';

class AppInputText extends StatelessWidget {
  final TextEditingController? textfieldcontroller;
  final String? header;
  final String? hint;
  final String? label;
  final Icon? icon;
  final Color? fillcolor;
  final IconButton? suffixicon;
  final bool obscure;
  final Function? validate;
  final Function(String)? onChange;
  final bool isemail;
  final double? circle;
  final bool? enabled;
  AppInputText({
    Key? key,
    this.hint,
    required this.textfieldcontroller,
    required this.isemail,
    required this.fillcolor,
    this.icon,
    this.suffixicon,
    this.onChange,
    this.header,
    this.label,
    required this.obscure,
    this.validate,
    this.circle,
    this.enabled,
  }) : super(key: key);

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
        TextFormField(
          enabled: enabled ?? true,
          onChanged: onChange,
          obscureText: obscure,
          obscuringCharacter: '*',
          controller: textfieldcontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(circle ?? 5.0),
            ),
            hintText: hint ?? null,
            hintStyle: TextStyle(color: AppConst.grey),
            filled: true,
            label: label != null
                ? AppText(
                    txt: label,
                    size: 15,
                    color: AppConst.secondary,
                  )
                : null,
            fillColor: fillcolor,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(circle ?? 5.0),
              borderSide: BorderSide(color: AppConst.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(circle ?? 5.0),
              borderSide: BorderSide(color: AppConst.black),
            ),
            prefixIcon: icon,
            suffixIcon: suffixicon,
          ),
          validator: (value) {
            RegExp regex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');
            if (isemail) {
              if (value!.isNotEmpty) {
                return null;
              } else if (value.isEmpty) {
                return "THis field cannot be empty";
              } else if (!regex.hasMatch(value)) {
                return 'Password should contain \n -at least one upper case \n -at least one lower case \n -at least one digit \n -at least one Special character \n -Must be at least 8 characters in length';
              }
            } else {
              if (value!.isNotEmpty) {
                return null;
              } else if (value.isEmpty) {
                return "THis field cannot be empty";
              }
            }
          },
        ),
      ],
    );
  }
}
