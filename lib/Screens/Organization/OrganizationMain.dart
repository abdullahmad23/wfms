import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste/Auth/VarificationScreen.dart';
import 'package:waste/Screens/Organization/OrganizationHome.dart';
import 'package:waste/Screens/Organization/OrganizationHotelList.dart';
import 'package:waste/Screens/Organization/OrganizationProfile.dart';
import 'package:waste/Screens/Organization/OrganizationRequests.dart';

class OrganizationMain extends StatefulWidget {
  const OrganizationMain({super.key});

  @override
  State<OrganizationMain> createState() => _OrganizationMainState();
}

class _OrganizationMainState extends State<OrganizationMain> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final pageIndex = [
    const OrganizationHome(),
    const OrganizationRequest(),
    const OrganizationHotelList(),
    const OrganizationProfile(),
  ];

  @override
  initState() {
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) => {
              if (value.data()?['varified'] == false)
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VarificationScreen(),
                    ),
                  )
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.request_quote, size: 30, color: Colors.white),
          Icon(Icons.restaurant_sharp, size: 30, color: Colors.white),
          Icon(Icons.account_balance_rounded, size: 30, color: Colors.white),
        ],
        color: const Color(0xff1b2e0d),
        buttonBackgroundColor: const Color(0xff7FBD50),
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        animationCurve: Curves.decelerate,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: pageIndex[_page],
    );
  }
}
