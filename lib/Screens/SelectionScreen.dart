import 'package:flutter/material.dart';
import 'package:waste/Auth/Signin.dart';
import 'package:waste/Components/ImgButton.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NaviGateToSignIn(String s) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(s),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/selection.png"),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("Choose Your Identity",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Please select the following. It will help us to find your service faster and in efficient manner.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImgButton('Organization', 'assets/Organization.png',
                              () {
                            NaviGateToSignIn('Organization');
                          }),
                          ImgButton('Client', 'assets/User.png', () {
                            NaviGateToSignIn('Client');
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImgButton('Hotel', 'assets/ServiceBell.png', () {
                            NaviGateToSignIn('Hotel');
                          }),
                          ImgButton('Admin', 'assets/UserShield.png', () {
                            NaviGateToSignIn('Admin');
                          }),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
