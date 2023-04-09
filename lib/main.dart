import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselogin/widgets/Coustom_Sigin_In/Coustom_Login.dart';
import 'package:firebaselogin/widgets/Google_signIn/Google_With_Sign_In.dart';
import 'package:firebaselogin/widgets/One_Time_Login_Mobile_Number/Mobile_Number.dart';
import 'package:firebaselogin/widgets/firebase_data_Send/firestore_data_Send.dart';
import 'package:flutter/material.dart';
import 'Fire_Realtime.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp( MyApp(

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var z=70;
    return MaterialApp(
      title: 'Firebase login',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: PostScreen(),
      //FirestoreDataSent(),
      // MobileNumber(),
     // CoustomLogin(),
      // FirebaseLoginExample(),
    );
  }
}









