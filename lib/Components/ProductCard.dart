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
              'Bajna Moterway Road \nShinkiari',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff4a4951),
              ),
            ),
            SizedBox(height: 8.0,),
            Row(
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
                  width: 50,
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
        SizedBox(child: Image.asset("assets/Mask group.png"))
      ],
    ),
  ) ,
    );
   
  }
}