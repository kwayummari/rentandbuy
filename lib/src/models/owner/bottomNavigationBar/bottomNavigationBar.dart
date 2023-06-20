// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, depend_on_referenced_packages, library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:cers/src/models/owner/home/homepage.dart';
import 'package:cers/src/models/owner/profile/profile.dart';
import 'package:cers/src/models/owner/yourItems/yourItems.dart';
import 'package:flutter/material.dart';
import 'package:cers/src/utils/app_const.dart';

class bottomNavigation extends StatefulWidget {
  const bottomNavigation({Key? key}) : super(key: key);

  @override
  _bottomNavigationState createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int index = 1;
  final Screen = [
    found(),
    Homepage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            body: Screen[index],
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: AppConst.black,
                primaryColor: AppConst.black,
              ),
              child: BottomNavigationBar(
                selectedItemColor: AppConst.secondary,
                unselectedItemColor: AppConst.whiteOpacity,
                backgroundColor: AppConst.primary,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.foundation), label: 'Your equipments'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Equipments'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ],
                currentIndex: index,
                onTap: (index) {
                  if (mounted) setState(() => this.index = index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
