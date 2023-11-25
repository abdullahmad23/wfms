import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';

class ClientHotelList extends StatefulWidget {
  const ClientHotelList({super.key});

  @override
  State<ClientHotelList> createState() => _ClientHotelListState();
}

class _ClientHotelListState extends State<ClientHotelList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(margin:EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
          AppLogo(),
          SizedBox(height: 5,),
          hallcontainer(),
          SizedBox(height: 5,),
          hallcontainer(),
          SizedBox(height: 5,),
          hallcontainer(),
          SizedBox(height: 5,),
          hallcontainer()
        ],),
      )
    );
  }
}
Widget hallcontainer(){
  return Container(height: 100,
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
                'AL Hamra Shadi Hall',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(height: 8.0,),
              Text(
                'Karakoeam Highway \n Marghazar Mansehra',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4a4951),
                ),
              ),
              SizedBox(height: 8.0,),
             
            ],
          ),
          SizedBox(child: Image.asset("assets/Mask group.png"))
        ],
      ),
      );
}