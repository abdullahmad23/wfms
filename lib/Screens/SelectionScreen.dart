import 'package:flutter/material.dart';
import 'package:waste/Components/ImgButton.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Container(height: 250,width: MediaQuery.of(context).size.width,
           child: Image.asset("assets/selection.png"),),
           SizedBox(height: 40,),
           Text(
              "Choose Your Identity",
              style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              )
              ),
               SizedBox(height: 10,),
           Text(
              "Please select the following. It will help us to find your service faster and in efficient manner.",
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              )
              ),
           SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImgButton('Organization', 'assets/Organization.png', (){}),
            ImgButton('Client', 'assets/User.png', (){}),
          ],
            ),SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImgButton('Hotel', 'assets/ServiceBell.png', (){}),
            ImgButton('Admin', 'assets/UserShield.png', (){}),
          ],
            ),
          ],
            ),
          )
              
              ],
          ),
        ),
      ),
    );
  }
}