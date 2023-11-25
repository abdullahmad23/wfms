import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste/Screens/Admin/AdminMain.dart';
import 'package:waste/Screens/Client/ClientMain.dart';
import 'package:waste/Screens/Hotel/HotelMain.dart';

import '../Screens/Organization/OrganizationMain.dart';

class SignIn extends StatefulWidget {
  final String title;
  const SignIn(this.title, {super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isSignInPage = true;
  final TextEditingController _FNameController = TextEditingController();
  final TextEditingController _LNameController = TextEditingController();
  final TextEditingController _PhNumController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PassWordController = TextEditingController();
  NavigateUser(String title) {
    if (title == widget.title) {
      switch (title) {
        case "Organization":
          {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const OrganizationMain())));
          }
          break;

        case "Admin":
          {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const AdminMain())));
          }
          break;

        case "Client":
          {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const ClientMain())));
          }
          break;

        case "Hotel":
          {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const HotelMain())));
          }
          break;

        default:
          {
            EasyLoading.showError('Something Went Wrong');
          }
          break;
      }
    } else {
      const SnackBar(content: Text('Not Authorized  '));
    }
  }

  HandleSignIn() async {
    EasyLoading.show(status: 'Please wait...');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _EmailController.text,
        password: _PassWordController.text,
      )
          .then((user) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.user!.uid)
            .get()
            .then((value) => {NavigateUser(value.data()?['type'])});
      });
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.code);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
    EasyLoading.dismiss();
  }

  HandleSignUp() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _EmailController.text,
        password: _PassWordController.text,
      )
          .then((User) {
        // Create a new user with a first and last name
        final user = <String, dynamic>{
          "first": _FNameController.text,
          "last": _LNameController.text,
          "email": _EmailController.text,
          "phone": _PhNumController.text,
          "type": widget.title,
          "varified": false,
          "img":'https://firebasestorage.googleapis.com/v0/b/wfms-c15a1.appspot.com/o/ertyu.png?alt=media&token=e29ea5fb-f048-4364-a713-4ac33fc88d8b'
        };
        FirebaseFirestore.instance
            .collection("users")
            .doc(User.user!.uid)
            .set(user)
            .then((val) {
          NavigateUser(widget.title);
          EasyLoading.dismiss();
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.showError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print(_EmailController.text);
    print(_PassWordController.text);
    print(_FNameController.text);
    print(_LNameController.text);
    print(_PhNumController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              // Got To LOgin
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSignInPage = true;
                  });
                },
                child: const Text('sign in'),
              ),
              // go to sign up
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSignInPage = false;
                  });
                },
                child: const Text('sign up'),
              ),
            ],
          ),
          // if Signin Is Enabled

          Visibility(
            visible: isSignInPage,
            child: Column(
              children: [
                TextField(
                  controller: _EmailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                TextField(
                  controller: _PassWordController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                ElevatedButton(
                  onPressed: HandleSignIn,
                  child: const Text('signin'),
                ),
              ],
            ),
          ),
          // if Signin is False
          Visibility(
            visible: !isSignInPage,
            child: Column(
              children: [
                TextField(
                  controller: _FNameController,
                  decoration: const InputDecoration(
                    label: Text('F'),
                  ),
                ),
                TextField(
                  controller: _LNameController,
                  decoration: const InputDecoration(
                    label: Text('l'),
                  ),
                ),
                TextField(
                  controller: _EmailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                TextField(
                  controller: _PassWordController,
                  decoration: const InputDecoration(
                    label: Text('Pass'),
                  ),
                ),
                TextField(
                  controller: _PhNumController,
                  decoration: const InputDecoration(
                    label: Text('Phnum'),
                  ),
                ),
                ElevatedButton(
                  onPressed: HandleSignUp,
                  child: const Text('signin'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
