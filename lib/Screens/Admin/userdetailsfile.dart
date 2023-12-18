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
  bool isVerified = false;
  @override
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

        isVerified = _user['varified'];
      });
    });
  }

  approveHandler() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({'varified': true}).then((User) {
      Navigator.pop(context);
    });
  }

  rejectedHandler() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({'varified': false}).then((User) {
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
              const Text(
                "Name :",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${_user['name']}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Type :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['type']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Phone :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['phone']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Mail :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['email']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Verified :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "${_user['verified']}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !isVerified
                  ? ElevatedButton(
                      onPressed: () {
                        approveHandler();
                      },
                      child: const Text("Approved"))
                  : ElevatedButton(
                      onPressed: () {
                        rejectedHandler();
                      },
                      child: const Text("Rejected"))
            ],
          )
        ],
      ),
    );
  }
}
