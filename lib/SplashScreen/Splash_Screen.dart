import 'package:flutter/material.dart';
import 'package:voice_craft/Home_Screen/home_screen.dart';
import 'package:voice_craft/Login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_craft/Splash/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 01).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInCirc),
    );

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkUserAuthentication();
      }
    });

    _controller.forward();
  }

  Future<void> _checkUserAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home_Screen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => On_Boarding_screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade50
            : Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SlideTransition(
          position: _animation.drive(Tween<Offset>(
            begin: Offset(0, -1),
            end: Offset(0, 0),
          )),
          child: Container(
            height: 370,
            width: 410,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
