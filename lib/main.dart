// import 'package:firebase_app/models/user_model.dart';
// import 'package:firebase_app/screens/wrapper.dart';
// import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lovestatus/home.dart';
// import 'package:provider/provider.dart';
// import './models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();    //add 
  await Firebase.initializeApp();                         //add
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
