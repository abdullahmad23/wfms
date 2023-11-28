import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste/Screens/SelectionScreen.dart';

class VarificationScreen extends StatelessWidget {
  const VarificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SafeArea(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Image.asset("assets/AppBarLogo.png"),
                  ),
            ],
          ),
          SizedBox(height: 50,),
          Icon(Icons.check_circle_outline_outlined,color: Colors.greenAccent,size: 20,),
           Text('Thank you for providing your',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,fontFamily:GoogleFonts.inter().fontFamily),),
           Text('info',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,fontFamily:GoogleFonts.inter().fontFamily),),
           Text('Well review your info and if we can confrim it, you"ll be able to access your account within approximately 24 hours',style: TextStyle(color: Colors.grey),),
           SizedBox(height: 70,),
           ElevatedButton(onPressed: (){ Navigator.push(context,
      MaterialPageRoute(builder: (context) => SelectionScreen()));} , child: Text('GO Back')),
        ],),
      )
    );
  }
}
