import 'package:flutter/material.dart';

Widget requestCardButton(String buttonText, Function() btnmethod) {
  return ElevatedButton(
    onPressed: btnmethod,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffFFFFFF).withOpacity(0.5),
    ),
    child: Text(buttonText),
  );
}
