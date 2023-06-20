// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:cers/routes/routes.dart';
import 'package:cers/routes/route-names.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
        initialRoute: RouteNames.splash,
        routes: routes,
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
            ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Rent and Buy',
        theme: ThemeData(
            cardColor: Color.fromARGB(255, 179, 93, 23),
            highlightColor: Color.fromARGB(255, 179, 93, 23),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.orange,
            ).copyWith(background: Color.fromARGB(255, 179, 93, 23))),
      );
}
