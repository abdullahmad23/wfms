import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste/Screens/SelectionScreen.dart';
import 'package:waste/firebase_options.dart';

import 'Screens/Client/ClientHome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(),
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
    builder: EasyLoading.init(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectionScreen()),
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
