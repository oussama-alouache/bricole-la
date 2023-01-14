import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:selkni/pages/HomePage.dart';
import 'package:selkni/pages/Main_page.dart';
import 'package:selkni/pages/user-interface/Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
