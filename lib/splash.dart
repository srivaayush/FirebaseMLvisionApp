import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:img_to_text/home.dart';
// import 'package:img_to_text/objectDetector.dart';
import 'package:img_to_text/dashboard.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:tflite/tflite.dart';

class SplashScreens extends StatefulWidget {
  SplashScreens({Key key}) : super(key: key);

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 0,
      navigateAfterSeconds: Dashboard(),
      title: new Text(
        'Image 2 Text Converter',
        style: new TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        // style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset("assets/img2text.png"),
      photoSize: 130,
      backgroundColor: Colors.black,
      loaderColor: Colors.white,
      loadingText: Text(
        "from ALMIPY",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}
