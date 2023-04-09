import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/utils/utils.dart';
import 'package:firebaselogin/widgets/Coustom_Button.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CoustomLogin extends StatefulWidget {
  const CoustomLogin({Key? key}) : super(key: key);

  @override
  State<CoustomLogin> createState() => _CoustomLoginState();
}

class _CoustomLoginState extends State<CoustomLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _Auth = FirebaseAuth.instance;
  bool _obscured = true;
  bool loading = false;
  bool Loginloading = false;
  bool Forgetloading = false;
  final _formkey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void Login() {
    setState(() {
      Loginloading = true;
    });
    _Auth.signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      setState(() {
        Loginloading = false;
      });
      email.clear();
      password.clear();
      Utils().toastMessage("Your Account is Login");
    }).onError((error, stackTrace) {
      setState(() {
        Loginloading = false;
      });
      email.clear();
      password.clear();
      Utils().toastMessage(error.toString());
    });
  }

  void SignIn() {
    setState(() {
      loading = true;
    });
    _Auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      Utils().toastMessage("Register your Account");
      setState(() {
        loading = false;
      });
      email.clear();
      password.clear();
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());

      email.clear();
      password.clear();
      setState(() {
        loading = false;
      });
    });
  }

  void Forget() {
    setState(() {
      Forgetloading = true;
    });
    _Auth.sendPasswordResetEmail(email: email.text).then((value) {
      Utils().toastMessage("Please check you email.");
      email.clear();
      email.clear();
      setState(() {
        Forgetloading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      email.clear();
      email.clear();
      setState(() {
        Forgetloading = false;
      });
    });
  }

  void Logout() {
    setState(() {
      Loginloading = true;
    });
    _Auth.signOut().then((value) {
      setState(() {
        Loginloading = false;
      });
      email.clear();
      password.clear();
      Utils().toastMessage("You account in logout.");
    }).onError((error, stackTrace) {
      Utils().toastMessage("You account all ready logout.");
      setState(() {
        email.clear();
        password.clear();
        Loginloading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_Auth.currentUser != null)
            Text(
              'You Account is Login  \n  email : ${_Auth.currentUser!.email}'
              '\n Uid : ${_Auth.currentUser!.uid}',
              style: const TextStyle(color: Colors.black),
            )
          else
            const Text("You Account is not login"),
          // ------------------------------------------------ email ----------------------------------------------
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
            child: TextFormField(
              validator: (val) {
                return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                    ? null
                    : "Please enter a valid email";
              },
              controller: email,
              style: TextStyle(color: primary),
              cursorColor: primary,
              decoration: const InputDecoration(
                label: Text(
                  "Email",
                  style: TextStyle(color: Colors.deepOrange),
                ),
                // suffix: Icon(Icons.co2),
                prefixIcon: Icon(
                  Icons.alternate_email_outlined,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // ------------------------------------------------ Password ----------------------------------------------
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
            child: TextFormField(
              controller: password,
              validator: (volue) {
                RegExp regex = RegExp(
                    r'^(?=.*?[a-z]|[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if (volue!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(volue)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(color: primary),
              cursorColor: primary,
              obscureText: _obscured,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: _toggleObscured,
                  child: Icon(
                    _obscured
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: primary,
                  ),
                ),
                hintText: "Enter Password",
                labelText: 'Password',
                labelStyle: TextStyle(color: primary),
                prefixIcon: Icon(
                  Icons.lock,
                  color: primary,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2.0),
                ),
              ),
            ),
          ),
          CoustomButton(
              title: "Create Account",
              onTap: () {
                SignIn();
              },
              isLoading: loading),
          if (_Auth.currentUser == null)
            CoustomButton(
                title: "Login",
                onTap: () {
                  Login();
                },
                isLoading: Loginloading)
          else
            CoustomButton(
                title: "Logout",
                onTap: () {
                  Logout();
                },
                isLoading: Loginloading),
          CoustomButton(
              title: "Forget your Password",
              onTap: () {
                Forget();
              },
              isLoading: Forgetloading),
        ],
      ),
    );
  }
}
