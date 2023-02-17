import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:selkni/pages/phone-auth/userinfo.dart';
import 'package:selkni/provider/auth_provider.dart';
import 'package:selkni/utilities/phoneutiliti.dart';

class Otp extends StatefulWidget {
  final String verificationId;

  const Otp({super.key, required this.verificationId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? otpcode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: prefer_const_constructors
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'verification ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ' code de verification ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orangeAccent),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  onCompleted: (value) {
                    setState(() {
                      otpcode = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      if (otpcode != null) {
                        otpverefication(context, otpcode!);
                      } else {
                        showsnakbar(context, "enytrez les 6 numero de code");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "se connecter avec google",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "vous avez pas recu de code ?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "vcliquez ici",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void otpverefication(BuildContext context, String userotp) {}
}
