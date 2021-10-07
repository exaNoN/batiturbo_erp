import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5000));
    return const SafeArea(
      child: Center(
        child: Text("splashScreen"),
      ),
    );
  }
}
