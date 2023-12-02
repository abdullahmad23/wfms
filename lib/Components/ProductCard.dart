import 'package:flutter/material.dart';
import 'package:waste/Screens/Client/FoodDetail.dart';

class ProductCard extends StatelessWidget {
final String name;

  const ProductCard({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetail()));
      },
      child:Container(
        width: MediaQuery.of(context).size.width*1,
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
              '$name',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Text(
              'KasraNoor Shadi Hall',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff7fbd50),
              ),
            ),
            SizedBox(height: 8.0,),
            Text(
              'Bajna Moterway \nRoad Shinkiari',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff4a4951),
              ),
            ),
            SizedBox(height: 8.0,),
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
                    Text('  50 kg'),
                  ],
                ),
                SizedBox(
                 width: MediaQuery.of(context).size.width *0.10,
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
                    Text('PKR 90/kg'),
                  ],
                ),
              ],
            ),
          ],
        ),

           SizedBox(width: 3.0,),
             
             Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   image:DecorationImage(

                     image:AssetImage("assets/Mask group.png"),
                     fit: BoxFit.cover,
                   ),
                 ),
                 width: MediaQuery.of(context).size.width*0.36,
                 height: MediaQuery.of(context).size.height*0.20,

             ),
      ],
    ),
  ) ,
    );
   
  }
}