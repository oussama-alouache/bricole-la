import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selkni/pages/phone-auth/otp_screen.dart';
import 'package:selkni/utilities/phoneutiliti.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _issignin = false;

  bool get issignin => _issignin;
  bool _isloeaed = false;
  bool get isloeaed => _isloeaed;

  String? _uid;

  String get uid => _uid!;

  AuthProvider() {
    checksignin();
  }

  void checksignin() async {
    final SharedPreferences siginincheck =
        await SharedPreferences.getInstance();
    _issignin = siginincheck.getBool("is_sigined") ?? false;
    notifyListeners();
  }

  void sigininwithphone(BuildContext context, String phonenumber) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.orangeAccent,
        ));
      },
    );

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phonenumber,
          timeout: Duration(),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: ((verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => Otp(verificationId: verificationId)),
              ),
            );
          }),
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showsnakbar(context, e.toString());
    }
  }

  void otpverefication({
    required BuildContext context,
    required String verificationId,
    required String userotp,
    required Function onsucess,
  }) async {
    _isloeaed = true;
    notifyListeners();
    try {
      PhoneAuthCredential creed = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userotp);

      User? user =
          (await FirebaseAuth.instance.signInWithCredential(creed)).user;

      if (user != null) {
        _uid = user.uid;
        onsucess();
      }
      _isloeaed = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showsnakbar(context, e.toString());
      _isloeaed = false;
      notifyListeners();
    }
  }

  Future<bool> checkuser() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("this user exsiste");
      return true;
    } else {
      print("new user");
      return false;
    }
  }
}
