import 'package:flutter/material.dart';

import '../../Components/AppLogo.dart';

class ClientRequest extends StatefulWidget {
  const ClientRequest({super.key});

  @override
  State<ClientRequest> createState() => _ClientRequestState();
}

class _ClientRequestState extends State<ClientRequest> {

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              AppLogo(),
              Text(
                'Request',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              Padding(
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
                      child: Text(
                        'Active',style: TextStyle(color: flag?Colors.white:Color(0xff1D331B)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: flag?Color(0xff1D331B):Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Color(0xff1D331B),
                          width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flag = false;
                        });
                      },
                      child: Text('History',style: TextStyle(color: flag?Color(0xff1D331B):Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: flag?Colors.transparent:Color(0xff1D331B),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Color(0xff1D331B),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: flag,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    RequestCard(Color(0xff5282FF), "Biryani", "pkr 440/10kg", "Pay Now", () { print('btn works');}),

                    SizedBox(height: 10),
                    RequestCard(Color(0xffE42424), "Biryani", "pkr 440/10kg", "Dismiss", () { setState(() {flag = false;});}),
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

  Widget RequestCard(Color bgColor,String productTitle,String productPrice,String btnText,Function() btnMethod){
    return   Container(
      padding: EdgeInsets.all(8.0),
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
              Text(productTitle, style: TextStyle(fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
              SizedBox(height: 3.0),

              Text(productPrice, style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
            ],
          ),
          ElevatedButton(
            onPressed: btnMethod,
            child: Text(btnText),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFFFFFF).withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
