import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';

class OrganizationHotelList extends StatefulWidget {
  const OrganizationHotelList({super.key});

  @override
  State<OrganizationHotelList> createState() => _OrganizationHotelListState();
}

class _OrganizationHotelListState extends State<OrganizationHotelList> {
  List<Map> HotelData = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotel();
  }

  getHotel() {
    FirebaseFirestore.instance
        .collection("users")
        .where('type', isEqualTo: "Hotel")
        .get()
        .then((hotelList) {
      print(hotelList);
      for (var hotel in hotelList.docs) {
        setState(() {
          HotelData.add(hotel.data());
        });
        print("updated");
        setState(() {
          isLoading = false;
        });
        print("updated");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  AppLogo(),
                  ...HotelData.map((hotel) => hallcontainer("${hotel['name']}",
                      "${hotel['img']}", "${hotel['address']}", context)),
                ],
              ),
            ),
          ));
  }
}

Widget hallcontainer(
    String hotelName, String Hotelimg, String hotelAddress, context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.20,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
        border: Border.all(), borderRadius: BorderRadius.circular(18)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hotelName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              hotelAddress,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff4a4951),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
        SizedBox(child: Image.network(Hotelimg)),
      ],
    ),
  );
}
