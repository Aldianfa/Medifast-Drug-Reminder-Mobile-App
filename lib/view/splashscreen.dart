import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uasmobile/view/menu.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void initState(){
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async{
    var duration = const Duration(seconds: 5);
    return Timer(duration, (){
      Navigator.push(context, MaterialPageRoute(builder: ((context) => Menu())));
    });
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/Splash.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img/Logo.png', height: 75, fit: BoxFit.cover),

          SizedBox(height: 24),

          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

}