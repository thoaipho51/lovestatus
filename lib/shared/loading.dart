import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[200],
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.pinkAccent,
          size: 100.0,
        ),
      ),
    );
  }
}