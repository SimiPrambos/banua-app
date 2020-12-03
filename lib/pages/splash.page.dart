import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final Widget nextPage;

  const SplashPage({Key key, this.nextPage}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  void splash() async {
    var _duration = Duration(seconds: 3);
    Timer(_duration, next);
  }

  void next() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => widget.nextPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
