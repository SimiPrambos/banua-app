import 'package:flutter/material.dart';
import 'package:ident/constants.dart';
import 'package:ident/controllers/app.controller.dart';
import 'package:ident/models/models.dart';
import 'package:ident/navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ident/pages/splash.page.dart';

void main() async {
  await initHive();
  runApp(withController(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme),
      ),
      home: SplashPage(
        nextPage: AppNavigation(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
