import 'package:lovestatus/models/user_model.dart';
import 'package:lovestatus/screens/wrapper.dart';
import 'package:lovestatus/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      catchError: (_,__) {},
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
