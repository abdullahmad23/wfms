import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';
import 'package:waste/Components/RequestCardButton.dart';

class HotelOrderRequests extends StatefulWidget {
  const HotelOrderRequests({super.key});

  @override
  State<HotelOrderRequests> createState() => _HotelOrderRequestsState();
}

class _HotelOrderRequestsState extends State<HotelOrderRequests> {
  bool flag = true;

  var documentId;

  List<Map<String, dynamic>> allRequest = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequests();
  }

  void getRequests() {
    String UserId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("offers")
        .where("HotelId", isEqualTo: UserId)
        .get()
        .then((request) {
      for (var req in request.docs) {
        Map<String, dynamic> temp = req.data();
        temp['id'] = req.id;
        setState(() {
          allRequest.add(temp);
        });
      }
    });
  }

  void setRequestStatus(String Did, String status) {
    FirebaseFirestore.instance
        .collection('offers')
        .doc(Did)
        .update({'status': status});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              AppLogo(),
              const Text(
                'Request',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 2.0,
                  color: Color(0xffD9DFEB),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            flag ? const Color(0xff1D331B) : Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Color(0xff1D331B),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(
                            color:
                                flag ? Colors.white : const Color(0xff1D331B)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            flag ? Colors.transparent : const Color(0xff1D331B),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Color(0xff1D331B),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'History',
                        style: TextStyle(
                            color:
                                flag ? const Color(0xff1D331B) : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: flag,
                child: Column(
                  children: [
                    ...allRequest.map((allreq) => RequestCard(
                        "${allreq['FoodTitle']}",
                        "${allreq['Price']} Pkr/${allreq['Qty']} Kg",
                        allreq['id']))
                  ],
                ),
              ),
              Visibility(
                visible: flag,
                child: Container(
                  width: double.infinity,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget RequestCard(
    String productTitle,
    String productPrice,
    String id,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productTitle,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 3.0),
              Text(productPrice,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ],
          ),
          Column(
            children: [
              requestCardButton("Accept", () {
                setRequestStatus(id, 'accepted');
              }),
              SizedBox(
                height: 2.0,
              ),
              requestCardButton("Reject", () {
                setRequestStatus(id, 'rejected');
              }),
            ],
          ),
        ],
      ),
    );
  }
}
