import 'package:flutter/material.dart';

class userlog extends StatefulWidget {
  const userlog({super.key});

  @override
  State<userlog> createState() => _userlogState();
}

class _userlogState extends State<userlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("hello you"),
      )),
    );
  }
}
