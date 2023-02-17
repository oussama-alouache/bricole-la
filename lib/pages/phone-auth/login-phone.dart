import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class PhonrLog extends StatefulWidget {
  const PhonrLog({super.key});

  @override
  State<PhonrLog> createState() => _PhonrLogState();
}

class _PhonrLogState extends State<PhonrLog> {
  final TextEditingController PhoneController = TextEditingController();

  Country seletedcountry = Country(
    phoneCode: "213",
    countryCode: "DZ",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Algerie",
    example: "Algerie",
    displayName: "Algerie",
    displayNameNoCountryCode: "DZ",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    PhoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: PhoneController.text.length,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 300,
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset("assets/phone1.jpg"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'voyez introduire un numero valabe ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'vous devez etre joinaible sur ce numero pour recevoir un SMS de confirmation ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: PhoneController,
                    onChanged: (value) {
                      setState(() {
                        PhoneController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: PhoneController.text.length > 10
                            ? OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              )
                            : null,
                        prefixIcon: Container(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: (() {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 300,
                                    ),
                                    onSelect: (value) {
                                      setState(() {
                                        seletedcountry = value;
                                      });
                                    });
                              }),
                              child: Text(
                                "${seletedcountry.flagEmoji} + ${seletedcountry.phoneCode}   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: PhoneController.text.length > 9
                            ? Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : null),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: sendnumber,
                      child: Container(
                        padding: EdgeInsets.all(20.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendnumber() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phonenumber = PhoneController.text.trim();
    ap.sigininwithphone(context, "+${seletedcountry.phoneCode}$phonenumber");
  }
}
