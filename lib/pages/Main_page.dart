import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selkni/map/google-map.dart';
import 'package:selkni/pages/auth/auth_page.dart';
import 'package:selkni/utilities/sidebar..dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MapG();
          } else {
            return const Auth();
          }
        },
      ),
    );
  }
}
