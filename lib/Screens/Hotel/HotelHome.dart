import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste/Components/AppLogo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste/Components/ProductCard.dart';
import 'package:waste/Screens/Hotel/HotelFoodDetail.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  List<Map> allProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() {
    try {
      String UserId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection("Food")
          .where("Created_By", isEqualTo: UserId)
          .get()
          .then((products) {
        for (var prod in products.docs) {
          setState(() {
            allProducts.add(prod.data());
          });
        }
      });
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  TextEditingController _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            AppLogo(),
            searchBar(),
            ...allProducts.map((dish) => foodcontainer(dish)),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      color: const Color(0xff1b2e0d),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50.0,
              child: TextField(
                controller: _searchBarController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  focusColor: const Color(0xff7FBD50),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ]),
    );
  }

  Widget foodcontainer(Map food) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HotelFoodDetail(foodDetails: food)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${food['Title']}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7fbd50)),
                        ),
                        Text('  ${food['Qty']} kg'),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7fbd50)),
                        ),
                        Text('PKR ${food['Price']}/kg'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
                height: 20.0,
                width: 20.0,
                child: Image.network("${food['img']}")),
          ],
        ),
      ),
    );
  }
}
