import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste/Screens/Admin/AdminMain.dart';
import 'package:waste/Screens/Client/ClientMain.dart';
import 'package:waste/Screens/Hotel/HotelMain.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/Organization/OrganizationMain.dart';

class SignIn extends StatefulWidget {
  final String title;

  const SignIn(this.title, {super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isSignInPage = true;
  bool ischangecolor = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _NameController = TextEditingController();
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
    if (_formkey.currentState!.validate()) {
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
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast('select fields');
    }
  }

  HandleSignUp() async {
    EasyLoading.show(status: 'Please wait...');
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _EmailController.text,
          password: _PassWordController.text,
        )
            .then((User) {
          // Create a new user with a first and last name
          final user = <String, dynamic>{
            "name": _NameController.text,
            "email": _EmailController.text,
            "phone": _PhNumController.text,
            "address": 'UnKonwn',
            "type": widget.title,
            "varified": false,
            "img":
                'https://firebasestorage.googleapis.com/v0/b/wfms-c15a1.appspot.com/o/ertyu.png?alt=media&token=e29ea5fb-f048-4364-a713-4ac33fc88d8b'
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
      print(_NameController.text);

      print(_PhNumController.text);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast('status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 40,
                      child: Image.asset("assets/AppBarLogo.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: Color(0Xff1B2E0D)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Got To LOgin
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0Xff1B2E0D),
                                elevation: 0),
                            onPressed: () {
                              setState(() {
                                isSignInPage = true;
                                ischangecolor = true;
                              });
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  color: ischangecolor
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          ),
                          // go to sign up
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0Xff1B2E0D),
                                elevation: 0),
                            onPressed: () {
                              setState(() {
                                isSignInPage = false;
                                ischangecolor = false;
                              });
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  color: ischangecolor
                                      ? Colors.grey
                                      : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                              color: Color.fromARGB(255, 255, 255, 255)),
                          width: MediaQuery.of(context).size.width,
                          height: 20,
                        ))
                  ],
                ),
                // if Signin Is Enabled

                Visibility(
                  visible: isSignInPage,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Client',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),

                          TextFormField(
                            controller: _EmailController,
                            decoration: const InputDecoration(
                                hintText: "Enter your Email"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email can't be Empty";
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]")
                                  .hasMatch(value)) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),

                          TextFormField(
                            controller: _PassWordController,
                            decoration: const InputDecoration(
                              hintText: "Enter your Password",
                              suffix: Icon(
                                Icons.visibility_off_rounded,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please fill the field";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Row(mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text('Forgot Password?'),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 20,
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(32), // <-- Radius
                                ),
                                backgroundColor: const Color(0Xff1B2E0D),
                                elevation: 0,
                                minimumSize: const Size(330, 60)),
                            onPressed: HandleSignIn,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // if Signin is False
                Visibility(
                  visible: !isSignInPage,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Client',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.inter().fontFamily),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _NameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Name ',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name field Not be empty";
                            }
                            return null;
                          },
                        ),
                        const Row(
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        TextFormField(
                            controller: _EmailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your Email ',
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email can't be empty";
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "please enter valid email";
                              } else {
                                return null;
                              }
                            }),
                        const Row(
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _PassWordController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your password ',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "plase enter a password";
                            } else if (!RegExp(
                                    '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$')
                                .hasMatch(value)) {
                              return "enter a stronge password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Row(
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _PhNumController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Phone Number ',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill the field";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(32), // <-- Radius
                              ),
                              backgroundColor: const Color(0Xff1B2E0D),
                              elevation: 0,
                              minimumSize: const Size(330, 50)),
                          onPressed: HandleSignUp,
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
