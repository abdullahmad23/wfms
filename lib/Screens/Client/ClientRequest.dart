import 'package:flutter/material.dart';

import '../../Components/AppLogo.dart';

class ClientRequest extends StatefulWidget {
  const ClientRequest({super.key});

  @override
  State<ClientRequest> createState() => _ClientRequestState();
}

class _ClientRequestState extends State<ClientRequest> {
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
                      onPressed: () {},
                      child: Text(
                        'Active',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1D331B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('History'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1D331B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Visibility(
                child:Column(
                  children: [
                     Container(
                       padding: EdgeInsets.all(8.0),
                       decoration:BoxDecoration(
                         color: Color(0xff5282FF),
                         borderRadius: BorderRadius.circular(10),

                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children:[
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,

                         children: [
                           Text('Biryani ',style: TextStyle(fontSize: 20,color:Colors.white,fontWeight:FontWeight.w600)),
                           SizedBox(height: 3.0),
                           Text('Pkr 400/10kg',style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.white)),
                         ],
                           ),
                           ElevatedButton(
                             onPressed: (){},
                             child: Text('Pay Now'),
                            style: ElevatedButton.styleFrom(
                             // backgroundColor: Color(0xff5282FF).withOpacity( ),
                            ),
                           ),
                         ],
                       ),
                     ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
