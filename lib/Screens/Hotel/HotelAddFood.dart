import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste/Components/AppLogo.dart';

class HotelAddFood extends StatefulWidget {
  const HotelAddFood({super.key});

  @override
  State<HotelAddFood> createState() => _HotelAddFoodState();
}

class _HotelAddFoodState extends State<HotelAddFood> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppLogo(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 82, 94, 116),
                  ),
                  child: const Text('add Picture'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Food Name ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Food quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Food quantity ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Food Expiry Date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Expiry Date ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Food Per/Kg Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Per/Kg Price ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
