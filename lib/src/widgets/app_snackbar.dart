import 'package:flutter/material.dart';
import 'package:cers/src/widgets/app_text.dart';

class AppSnackbar extends SnackBar {
  final String? response;
  final bool? isError;

  AppSnackbar({
    Key? key,
    required this.response,
    required this.isError,
  }) : super(
          backgroundColor: isError == false ? Colors.green : Colors.black,
          content: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: AppText(
                key: UniqueKey(),
                txt: response.toString(),
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          duration: Duration(seconds: 3),
        );

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}
