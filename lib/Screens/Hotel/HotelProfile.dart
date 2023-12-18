import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste/Components/AppLogo.dart';
import 'package:waste/Screens/SelectionScreen.dart';

import 'ClientProfileEdit.dart';

class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key});

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  Map<String, dynamic> UserDetails = {};
  bool isLoading = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserDetails();
  }

  GetUserDetails() {
    String UserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(UserId)
          .get()
          .then((userDetails) {
        setState(() {
          UserDetails = userDetails.data()!;
          print(UserDetails);
          isLoading = false;


        });
      });
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90.0,
        titleTextStyle: TextStyle(fontSize: 12.01),

        title: AppLogo(),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HotelProfileEdit()));
            },
            child: Icon(Icons.edit,size: 20.0,color: Color(0xff7FBD50),weight: 500),
          ),],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Color(0xff1D331B),
                            ),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(UserDetails['name'],
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.mail_outline_rounded,
                                      color: Colors.white,), SizedBox(width: 5,),
                                    Text(UserDetails['email'],
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ],
                            ),

                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 20,
                          )),
                      Positioned(
                        right: MediaQuery
                            .of(context)
                            .size
                            .width / 2 - 50,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(UserDetails["img"]),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone', style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),),
                        Text(UserDetails['phone']),

                        Padding(
                          padding:EdgeInsets.all(8.0),
                          child: Divider(color: Colors.grey),
                        ),

                        Text('Address', style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),),
                        Text("Address"),

                        SizedBox(height:MediaQuery.of(context).size.height*0.02),
                        Center(
                          child: ElevatedButton(style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 4, 32, 8)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),

                                  )
                              )
                          ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SelectionScreen()));
                              },
                              child: Text('Logout')),
                        ),

                      ],
                    ),
                  ),





                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}
