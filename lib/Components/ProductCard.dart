import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste/Screens/Client/FoodDetail.dart';

class ProductCard extends StatefulWidget {
  final Map data;

  const ProductCard({super.key, required this.data});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Map HotelData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.data['Created_By'])
        .get()
        .then((value) {
      if (value.data() != null) {
        setState(() {
          HotelData = value.data()!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetail(
                      foodData: widget.data,
                      HotelDetails: HotelData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(18)),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.data['Title']}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  "${HotelData['name']}",
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
                  "${HotelData['address']}",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text("${widget.data['Qty']} kg"),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
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
                        Text('PKR ${widget.data['Price']}/kg'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 3.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: widget.data['img'] != null
                      ? NetworkImage(widget.data['img'])
                      : NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/wfms-c15a1.appspot.com/o/ertyu.png?alt=media&token=e29ea5fb-f048-4364-a713-4ac33fc88d8b"),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.36,
              height: MediaQuery.of(context).size.height * 0.20,
            ),
          ],
        ),
      ),
    );
  }
}
