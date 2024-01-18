import 'package:flutter/material.dart';

class ImgButton extends StatelessWidget {
  final String name;
  final String img;
  Function onPressed;
  ImgButton(this.name, this.img, this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        height: 125,
        width: 125,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Image.asset(img),
            Text(name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}
