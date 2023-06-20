import 'package:cers/src/models/owner/add/add.dart';
import 'package:cers/src/models/owner/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:cers/src/models/owner/request/request.dart';
import 'package:cers/src/models/renter/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:cers/src/models/authentication/login.dart';
import 'package:cers/src/models/authentication/registration.dart';
import 'package:cers/src/models/owner/home/homepage.dart';
import 'package:cers/src/models/splash.dart';
import 'package:cers/routes/route-names.dart';

final Map<String, WidgetBuilder> routes = {
  RouteNames.login: (context) => Login(),
  RouteNames.registration: (context) => Registration(),
  RouteNames.splash: (context) => Splash(),
  RouteNames.home: (context) => Homepage(),
  RouteNames.bottomNavigation: (context) => bottomNavigation(),
  RouteNames.bottomRenterNavigation:(context) => bottomRenterNavigation(),
  RouteNames.add: (context) => Add(),
  RouteNames.requets: (context) => request(),
};
