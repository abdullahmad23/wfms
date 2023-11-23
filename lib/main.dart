import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste/Screens/SelectionScreen.dart';
import 'package:waste/firebase_options.dart';
import 'package:waste/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MaterialApp(
    theme: ThemeData(),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectionScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
          'assets/SplashScreen.png',
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        
     
   
    );
  }
}

