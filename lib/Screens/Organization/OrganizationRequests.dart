import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';

class OrganizationRequest extends StatefulWidget {
  const OrganizationRequest({super.key});

  @override
  State<OrganizationRequest> createState() => _OrganizationRequestState();
}

class _OrganizationRequestState extends State<OrganizationRequest> {
  bool flag = true;

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
                    const SizedBox(height: 10),
                    RequestCard(const Color(0xff5282FF), "Biryani",
                        "pkr 440/10kg", "Pay Now", () {
                      print('btn works');
                    }),
                    const SizedBox(height: 10),
                    RequestCard(const Color(0xffE42424), "Biryani",
                        "pkr 440/10kg", "Dismiss", () {
                      setState(() {
                        flag = false;
                      });
                    }),
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

  Widget RequestCard(Color bgColor, String productTitle, String productPrice,
      String btnText, Function() btnMethod) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bgColor,
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
          ElevatedButton(
            onPressed: btnMethod,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFFFFFF).withOpacity(0.5),
            ),
            child: Text(btnText),
          ),
        ],
      ),
    );
  }
}
