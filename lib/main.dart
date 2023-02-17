import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:selkni/pages/Main_page.dart';
import 'package:selkni/provider/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocationPermission permission = await Geolocator.requestPermission();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        )
      ],
      child: const MaterialApp(
        title: 'Bricole-la',
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
