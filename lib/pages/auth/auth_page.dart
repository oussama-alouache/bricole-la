import 'package:flutter/material.dart';
import 'package:selkni/pages/user-interface/Login.dart';
import 'package:selkni/pages/user-interface/regester.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // login logic
  bool showloginpage = true;
  void togglescreen() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return Login(showregisterpage: togglescreen);
    } else {
      return Regester(showloginpage: togglescreen);
    }
  }
}
