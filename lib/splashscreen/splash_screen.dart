import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_week2/pages/login_screen.dart';
import 'dart:async';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            // child: Image(image: AssetImage("assets/png/coffee_logo.png"),width: 300,height: 300,),
          ),
          const SizedBox(height: 300,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color.fromARGB(255, 64, 64, 94),
                rightDotColor: const Color.fromARGB(255, 161, 76, 123),
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}