// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:cers/src/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cers/routes/route-names.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatortohome();
  }

  var email;
  var role;
  _navigatortohome() async {
    await getValidationData().whenComplete(() async {
      await Future.delayed(Duration(seconds: 1), () {});
      if (email == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.login, (_) => false);
      } else if (email != null && role == 'owner') {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.bottomNavigation, (_) => false);
      } else if (email != null && role == 'renter') {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.bottomRenterNavigation, (_) => false);
      }
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var e = sharedPreferences.get('email');
    var r = sharedPreferences.get('role');
    setState(() {
      email = e;
      role = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.primary,
      body: Center(
          child: SpinKitPouringHourGlassRefined(
        duration: const Duration(seconds: 3),
        size: 100,
        color: AppConst.secondary,
      )),
    );
  }
}
