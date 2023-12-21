import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodDetail extends StatefulWidget {
  final Map foodData;
  final Map HotelDetails;
  const FoodDetail(
      {super.key, required this.foodData, required this.HotelDetails});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  late String price = widget.foodData['Price'];
  late String qty = widget.foodData['Qty'];
  Map<String, dynamic> UserDetails = {};

  late int total = int.parse(price) * int.parse(qty);

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void submitOrder() {
    print('pressed');
    try {
      String UserId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection("users")
          .doc(UserId)
          .get()
          .then((userData) {
        setState(() {
          UserDetails = userData.data()!;
        });
      });
      FirebaseFirestore.instance.collection("offers").add({
        "Price": _priceController.text,
        "Qty": _quantityController.text,
        "creted_by": UserId,
        "CustomerName": UserDetails['name'],
        "Status": "pending",
        "Dismiss": false,
        "FoodTitle": widget.foodData['Title'],
        "HotelId": widget.foodData['Created_By'],
      }).then((value) {});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  ShowOfferModel() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)),
      ),
      context: context,
      builder: (context) {
        return Column(
          children: [
            Text("${widget.foodData['Title']}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Quantity",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter your quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the border radius as needed
                      borderSide: const BorderSide(
                        color: Colors.black, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the border radius as needed
                      borderSide: const BorderSide(
                        color: Colors.black, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width - 50, 60)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff1D331B)),
                    ),
                    onPressed: submitOrder,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff7FBD50),
        ),
        title: const Text(
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
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${widget.foodData['img']}'),
                    fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
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
                      Text("${widget.foodData['Title']}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Amount: ${widget.foodData['Qty']} KG",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Price: PKR ${widget.foodData['Price']}/KG",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Total: PKR $total/$qty KG",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Expiry Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          Text("${widget.foodData['Exp']}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Hotel Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${widget.HotelDetails['name']}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Address ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${widget.HotelDetails['address']}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width - 50, 60)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff1D331B)),
                  ),
                  onPressed: ShowOfferModel,
                  child: const Text("Send Offer",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
