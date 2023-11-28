import 'package:flutter/material.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_new,
        color: Color(0xff7FBD50),),
        title: Text("Food Details",
        style: TextStyle(
          fontSize: 24,fontWeight: FontWeight.w500,
          color: Color(0xff7FBD50)
          ),
        ),
        centerTitle: true,
      ),
      body:Column(
        children: [
        Container(width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.4,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Mask group.png'),fit: BoxFit.fill),
        ),
        ),SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Biryani",
                style: TextStyle(
                fontSize: 24,fontWeight: FontWeight.w500,
               )
               ),
                Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Text("Amount: 50 KG",
                  style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        )
                  ),
                  Text("Price:PKR 100/KG",
                  style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        )
                  ),
                  Text("Total: PKR 4000/50 KG",
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  )
                  ),
                ],)
              ],),
               
          Divider(color: Colors.black,),
          SizedBox(height: 10,),
          Row(children: [
            Icon(Icons.date_range,color: Colors.green,),SizedBox(width: 5,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Expiry Date",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              )),
              Text("May 20, 2023 ",style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              )),
            ],)
          ],),SizedBox(height: 15,),
          Text("Hotel Name",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              )),SizedBox(height: 5,),
          Text("Softxion Shadi Hall",style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              )),SizedBox(height: 10,),
          Text("Address ",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              )),SizedBox(height: 5,),
          Text("Hazara University ",style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              )),
                 ],
          ),
        ),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width-50,
               60)), 
               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                backgroundColor: MaterialStateProperty.all(Color(0xff1D331B)),),
                onPressed: (){
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40) ),
                    ),
                    context: context, builder: (context){return Container(height: MediaQuery.of(context).size.height*0.5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                 ),
                 child: Column(children: [
                  Text("data")
                 ],),
                  );
                  },);
                }, child: Text(
                    "Send Offer",
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )
                      )),
            )
      ],) ,
    );
  }
}