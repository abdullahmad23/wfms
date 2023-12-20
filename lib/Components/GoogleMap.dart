import 'package:flutter/material.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({super.key});

  @override
  State<GoogleMap> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/google_map_logo.png",
            ),
          ),
        ),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
