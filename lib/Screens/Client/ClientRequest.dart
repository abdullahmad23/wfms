import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste/Components/RequestCardButton.dart';
import 'package:waste/Components/GoogleMap.dart';

import '../../Components/AppLogo.dart';

class ClientRequest extends StatefulWidget {
  const ClientRequest({super.key});

  @override
  State<ClientRequest> createState() => _ClientRequestState();
}

class _ClientRequestState extends State<ClientRequest> {
  bool flag = true;
  final String _requeststatus = "";
  List<Map<String, dynamic>> request = [];
  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() {
    String UserId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("offers")
        .where("creted_by", isEqualTo: UserId)
        .get()
        .then((requests) {
      for (var req in requests.docs) {
        setState(() {
          request.add(req.data());
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
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
                              backgroundColor: flag
                                  ? const Color(0xff1D331B)
                                  : Colors.transparent,
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
                                  color: flag
                                      ? Colors.white
                                      : const Color(0xff1D331B)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                flag = false;

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GoogleMap()));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag
                                  ? Colors.transparent
                                  : const Color(0xff1D331B),
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
                                  color: flag
                                      ? const Color(0xff1D331B)
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: flag,
                      child: Column(children: [
                        ...request
                            .map((req) => RequestCard(
                                  "${req['Status']}",
                                  "${req['FoodTitle']}",
                                  "${req['Price']} Pkr/${req['Qty']} Kg",
                                ))
                            .toList(),
                      ]),
                    ),
                    Visibility(
                      visible: !flag,
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
      String requestStatus, String productTitle, String productPrice) {
    bool pending = false;
    bool accepted = false;
    bool rejected = false;
    if (requestStatus == 'pending') {
      setState(() {
        pending = true;
      });
    } else if (requestStatus == 'rejected') {
      setState(() {
        accepted = true;
      });
    } else if (requestStatus == 'accepted') {
      setState(() {
        rejected = true;
      });
    }
    print('requestStatus: $requestStatus');
    print('pending:$pending');
    print(':rejected$rejected');
    print('accepted:$accepted');

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.red,
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
              Visibility(
                  visible: pending,
                  child: requestCardButton('pending', () => null)),

              Visibility(
                  visible: accepted,
                  child: requestCardButton('accepted', () => null)),

              Visibility(
                  visible: rejected,
                  child: requestCardButton('rejected', () => null)),

              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xffFFFFFF).withOpacity(0.5),
              //   ),
              //   child: Text(requestStatus),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
