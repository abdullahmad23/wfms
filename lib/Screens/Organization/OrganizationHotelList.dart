import 'package:flutter/material.dart';
import 'package:waste/Components/AppLogo.dart';

class OrganizationHotelList extends StatefulWidget {
  const OrganizationHotelList({super.key});

  @override
  State<OrganizationHotelList> createState() => _OrganizationHotelListState();
}

class _OrganizationHotelListState extends State<OrganizationHotelList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          AppLogo(),
          const SizedBox(
            height: 5,
          ),
          hallcontainer(),
          const SizedBox(
            height: 5,
          ),
          hallcontainer(),
          const SizedBox(
            height: 5,
          ),
          hallcontainer(),
          const SizedBox(
            height: 5,
          ),
          hallcontainer()
        ],
      ),
    ));
  }
}

Widget hallcontainer() {
  return Container(
    height: 100,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
        border: Border.all(), borderRadius: BorderRadius.circular(18)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AL Hamra Shadi Hall',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Karakoeam Highway \nMarghazar Mansehra',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff4a4951),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
        SizedBox(child: Image.asset("assets/Mask group.png"))
      ],
    ),
  );
}
