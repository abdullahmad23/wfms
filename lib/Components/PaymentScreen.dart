import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste/Components/AppLogo.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _cardSecurityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              AppLogo(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.asset("assets/debitCard.png"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Enter Card Details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: GoogleFonts.inter().fontFamily),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        hintText: "Card Number",
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name field Not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    TextFormField(
                      controller: _cardNameController,
                      decoration: const InputDecoration(
                        hintText: "Name On the Card ",
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field Not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: TextFormField(
                            controller: _cardSecurityController,
                            decoration: const InputDecoration(
                              hintText: "Expiry Date",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "field Not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: TextFormField(
                            controller: _cardSecurityController,
                            decoration: const InputDecoration(
                              hintText: "Security Code",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "field Not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
