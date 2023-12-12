import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';
import 'package:waste/Components/ProductCard.dart';

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({super.key});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  List<Map> foodDetails = [];
  TextEditingController searchBarText = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    FirebaseFirestore.instance.collection("Food").get().then((foods) {
      print(foods);
      print(
          "=======================   ==============   =======================");
      print("not responding");
      for (var food in foods.docs) {
        setState(() {
          foodDetails.add(food.data());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            const SizedBox(
              width: double.infinity,
            ),
            AppLogo(),
            const SizedBox(
              height: 8.0,
            ),
            searchBar(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ...foodDetails
                      .map((food) => ProductCard(data: food))
                      .toList(),
                ],
              ),
            )
          ]),
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
                controller: searchBarText,
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
}

Widget foodcontainer() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
        border: Border.all(), borderRadius: BorderRadius.circular(18)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biryani',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Text(
              'KasraNoor Shadi Hall',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff7fbd50),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Bajna Moterway Road \nShinkiari',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff4a4951),
              ),
            ),
            SizedBox(
              height: 8.0,
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
                    Text('  50 kg'),
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
                    Text('PKR 90/kg'),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(child: Image.asset("assets/Mask group.png"))
      ],
    ),
  );
}
