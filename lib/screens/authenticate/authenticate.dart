import 'package:lovestatus/screens/authenticate/sign_in.dart';
import 'package:lovestatus/screens/authenticate/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = false;

  void toggleChangeView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignUp(toggleChangeView: toggleChangeView) :SignIn(toggleChangeView: toggleChangeView);;
  }
}