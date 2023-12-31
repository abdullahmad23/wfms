import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste/Screens/Client/FoodDetail.dart';
import 'package:waste/Screens/Hotel/HotelHome.dart';
import 'package:waste/Screens/Hotel/HotelMain.dart';

class HotelFoodDetail extends StatefulWidget {
  final Map foodDetails;
  const HotelFoodDetail({super.key, required this.foodDetails});

  @override
  State<HotelFoodDetail> createState() => _HotelFoodDetailState();
}

class _HotelFoodDetailState extends State<HotelFoodDetail> {
  late String qty = widget.foodDetails['Qty'];
  late String price = widget.foodDetails['Price'];
  late int total = int.parse(price) + int.parse(qty);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void deleteFood() async {
    try {
      var foodDocId = widget.foodDetails['id'];
      FirebaseFirestore.instance
          .collection("Food")
          .doc(foodDocId)
          .delete()
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HotelMain())));
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
    } catch (e) {
      print(e);
    }
  }

  void Removebtn() {
    EasyLoading.show(status: "please wait...");
    deleteFood();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Color(0xff7FBD50),
            )),
        title: Text(
          "Food Details",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xff7FBD50)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('${widget.foodDetails['img']}'),
                  fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text("${widget.foodDetails['Title']}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Amount: ${widget.foodDetails['Qty']} KG",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        Text("Price: PKR ${widget.foodDetails['Price']}/KG",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        Text("Total: PKR $total/$qty KG",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expiry Date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        Text("${widget.foodDetails['Exp']}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width - 50, 60)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff1D331B)),
                      ),
                      onPressed: Removebtn,
                      child: Text("Remove",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ))),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
