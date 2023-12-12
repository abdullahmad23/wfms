import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  final String id;
  const UserDetailsPage(this.id, {super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  Map _user = {};
  void initState() {
    getUser();
  }

  getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get()
        .then((User) {
      setState(() {
        _user = User.data()!;
      });
    });
  }

  approveHandler() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({'verified': true}).then((User) {
      Navigator.pop(context);
    });
  }

  rejectedHandler() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({'verified': false}).then((User) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${_user['img']}"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Name :",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${_user['name']}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Type :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['type']}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Phone :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['phone']}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Mail :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['email']}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Verified :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['verified']}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    approveHandler();
                  },
                  child: Text("Approved")),
              ElevatedButton(
                  onPressed: () {
                    rejectedHandler();
                  },
                  child: Text("Rejected"))
            ],
          )
        ],
      ),
    );
  }
}
