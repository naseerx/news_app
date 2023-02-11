import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/register_screen.dart';
import 'constant.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: Bimg, fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
        body:  AnimatedSplashScreen(
          splash: Column(
            children: const [
              Center(child: Text('WELCOME',style: KsplashFont,)),
              SizedBox(height: 20,),
              CircleAvatar(
                radius: 60,
                backgroundImage: logo,
              ),
              SizedBox(height: 20,),
              Text('WORLD LOOKOUT',style: KsplashFont),
            ],
          ),
          nextScreen: const register_screen(),
          splashIconSize: 250,
          duration: 4000,
          splashTransition: SplashTransition. slideTransition,

        ),
      ),
    );

  }
}
