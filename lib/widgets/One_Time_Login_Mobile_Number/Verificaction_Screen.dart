import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/utils/utils.dart';
import 'package:firebaselogin/widgets/Coustom_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';





class VerificactionScreen extends StatefulWidget {
  final String VerificactionId ;
   VerificactionScreen({Key? key,required this.VerificactionId}) : super(key: key);

  @override
  State<VerificactionScreen> createState() => _VerificactionScreenState();
}

class _VerificactionScreenState extends State<VerificactionScreen> {
  final _Auth = FirebaseAuth.instance;

String VerificationCode = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: ( code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: ( verificationCode){
              VerificationCode = verificationCode;
              // showDialog(
              //     context: context,
              //     builder: (context){
              //       return AlertDialog(
              //         title: Text("Verification Code"),
              //         content: Text('Code entered is $verificationCode'),
              //       );
              //     }
              // );
            }, // end onSubmit
          ),
          CoustomButton(title: "Verifi", onTap: () async {


            final crendital = PhoneAuthProvider.credential(
                verificationId: widget.VerificactionId, smsCode: VerificationCode);
            try{
              await _Auth.signInWithCredential(crendital);
              Utils().toastMessage("Your Account is login.");
            }catch(error){
              Utils().toastMessage(error.toString());
            }
            
          }, isLoading: loading)
        ],
      ),


    );
  }
}
