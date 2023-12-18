import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminApplicationStats extends StatefulWidget {
  const AdminApplicationStats({Key? key}) : super(key: key);

  @override
  State<AdminApplicationStats> createState() => _AdminApplicationStatsState();
}

class _AdminApplicationStatsState extends State<AdminApplicationStats> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getstats();
  }

  int _totalOrg = 0;
  int _totalHotels = 0;
  int _totalUser = 0;
  final urlImges = [
    "assets/hotelVector1.png",
    "assets/hotelVector2.png",
    "assets/hotelVector1.png",
    "assets/hotelVector2.png",
  ];
  Getstats() async {
    final qurey = FirebaseFirestore.instance.collection('users');
    // Get Count of Organization
    qurey.where('type', isEqualTo: 'Organization').count().get().then((value) {
      setState(() {
        _totalOrg = value.count;
      });
    });
    // Get Count of Hotel
    qurey.where('type', isEqualTo: 'Hotel').count().get().then((value) {
      setState(() {
        _totalHotels = value.count;
      });
    });
    // Get Count of Hotel
    qurey.where('type', isEqualTo: 'Client').count().get().then((value) {
      setState(() {
        _totalUser = value.count;
      });
    });
    // qurey.where('type', isEqualTo: 'Hotel').get().then((value)  {
    //   setState(() {

    //     for (var i = 0; i < count; i++) {

    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
              child: CarouselSlider.builder(
                itemCount: urlImges.length,
                itemBuilder: (context, Index, realIndex) {
                  final urlImage = urlImges[Index];
                  return buildImage(urlImage, Index);
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.3,
                  autoPlay: true,
                ),
              ),
            ),

            //==================== end pie chart ===========

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statesCard(text: "Organization", totalNo: "$_totalOrg"),
                statesCard(text: "Hotel", totalNo: "$_totalHotels"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                statesCard(text: "User", totalNo: "$_totalUser"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int Index) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.grey,
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget statesCard({required String text, required String totalNo}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
        color: const Color(0xff7FBD50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          totalNo,
          style: const TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400),
        )
      ]),
    );
  }
}
