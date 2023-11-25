import 'package:flutter/material.dart';

Widget AppLogo(){
  return Container(
      child:Column(
        children: [
          Image.asset('assets/WfmsLogo.png'),
          Text('WAST FOOD MANAGMENT',style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,),),
        ],
      ),
  );

}