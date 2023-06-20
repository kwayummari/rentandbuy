// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, depend_on_referenced_packages, library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:cers/src/models/renter/rented/rented.dart';
import 'package:cers/src/models/renter/home/homepage.dart';
import 'package:cers/src/models/renter/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:cers/src/utils/app_const.dart';

class bottomRenterNavigation extends StatefulWidget {
  const bottomRenterNavigation({Key? key}) : super(key: key);

  @override
  _bottomRenterNavigationState createState() => _bottomRenterNavigationState();
}

class _bottomRenterNavigationState extends State<bottomRenterNavigation> {
  int index = 1;
  final Screen = [
    rented(),
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
                      icon: Icon(Icons.foundation), label: 'Your Inquiry'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'All Equipments'),
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
