import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste/Screens/Admin/userdetailsfile.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final List<Map> _Users = [];
  @override
  void initState() {
    getUsers();
    print('hello');
  }

  getUsers() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .where('varified', isEqualTo: false)
        .get()
        .then((Users) {
      for (var user in Users.docs) {
        if (user.id == uid) {
        } else {
          Map temp = user.data();
          temp['id'] = user.id;
          setState(() {
            print(temp);
            _Users.add(temp);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: _Users.map(
          (user) => Userdetails(context, "${user['name']}", "${user['type']}",
              "${user['phone']}", "${user['id']}"),
        ).toList(),
      ),
    ));
  }
}

Widget Userdetails(context, name, type, address, id) {
  // String pname;
  // String rname;
  // String address;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetailsPage(id)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(15.0) //                 <--- border radius here
                ),
            border: Border.all(color: Colors.blueAccent)),
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1 / 9,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/9489458/pexels-photo-9489458.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name),
                Text(type),
                Text(address),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: Icon(Icons.arrow_forward),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}
