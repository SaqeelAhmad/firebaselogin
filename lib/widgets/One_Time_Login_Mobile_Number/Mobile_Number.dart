import 'package:firebaselogin/utils/utils.dart';
import 'package:firebaselogin/widgets/Coustom_Button.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../utils/colors.dart';

import 'package:intl_phone_field/intl_phone_field.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'Verificaction_Screen.dart';


class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {


  String MobileNumber = '' ;


  bool loading = false;

  final _Auth = FirebaseAuth.instance;

  void oneTime (){
    setState(() {
      loading = true;
    });
    _Auth.verifyPhoneNumber(
        phoneNumber: MobileNumber,
        timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
      verificationFailed: (FirebaseAuthException error) { Utils().toastMessage(error.toString());
          setState((){loading =false;});},
      codeSent: (String verificationId, int? forceResendingToken) {
    setState((){loading =false;});
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VerificactionScreen(
            VerificactionId: verificationId ,
          )));},
      codeAutoRetrievalTimeout: (String verificationId) {   },



    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

    Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_Auth.currentUser != null)CoustomButton(title: "Logout", onTap: (){_Auth.signOut()
          .then((value) {
            setState(() {
              Utils().toastMessage("Logout your account");
            });
          }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });}, isLoading: loading)else
          // ------------------------------------------------ Mobile number ----------------------------------------------
          Padding(
            padding:
            const EdgeInsets.only(right: 20, left: 20, top: 10),
            child: IntlPhoneField(
              style: TextStyle(color: primary),
              cursorColor: primary,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
              initialCountryCode: 'PK',
              onChanged: (phone) {
                setState(() {
                  MobileNumber = phone.completeNumber;
                });
              },
            ),
          ),
          if (_Auth.currentUser == null)
          CoustomButton(title: "Login with mobile Number", onTap: (){oneTime();
print(MobileNumber);
            }, isLoading: loading),


          if (_Auth.currentUser == null)
          CoustomButton(title: "Login with Anonymous", onTap: (){Anonymously();}, isLoading: loading)



        ],
      ),
    );
  }
  Future<void> Anonymously() async {
    await _Auth.signInAnonymously();
  }
}
