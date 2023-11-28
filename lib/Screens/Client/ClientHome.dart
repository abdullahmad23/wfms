import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';
import 'package:waste/Components/ProductCard.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  TextEditingController searchBarText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
          ),
          AppLogo(),
          SizedBox(height: 8.0,),
          searchBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              ProductCard( name:'biryani'),
              ProductCard( name:'kala'),
            
       
            ]),
          )
        ]),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      color: Color(0xff1b2e0d),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50.0,
              child: TextField(
                controller: searchBarText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  focusColor: Color(0xff7FBD50),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ]),
    );
  }
}

Widget foodcontainer() {
  return Container(
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
              'Biryani',
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
  );
}
