
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
  bool ischangecolor =false;
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
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
              SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
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
                              backgroundColor: Color(0Xff1B2E0D), elevation: 0),
                          onPressed: () {
                            setState(() {
                              isSignInPage = true;
                            });
                          },
                          child: 
                      Text('LOGIN',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily:GoogleFonts.inter().fontFamily,color: ischangecolor?Colors.white:Colors.grey),),

                        ),
                        // go to sign up
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0Xff1B2E0D), elevation: 0),
                          onPressed: () {
                            
                            setState(() {
                              isSignInPage = false;
                            });
                          },
                          child: 
                      Text('SIGN UP',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily:GoogleFonts.inter().fontFamily,color: ischangecolor?Colors.white:Colors.grey),),

                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
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
                child: Container(
                  height: 6000,
                  width: MediaQuery.of(context).size.width,
                
                  child: Column(
                    children: [
                      Text('Client',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text('Email',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                        ],
                      ),

                      TextField(
                        controller: _EmailController,
                        decoration: const InputDecoration(
                        
                          hintText: "Enter your Email"
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text('Password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                        ],
                      ),

                      TextField(
                        controller: _PassWordController,
                        decoration: const InputDecoration(
                         
                          hintText: "Enter your Password",
                          suffix: Icon(Icons.visibility_off_rounded,color: Colors.grey,size: 20,),
                        ),
                      ),
                      SizedBox(height: 20,),
                      // Row(mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text('Forgot Password?'),
                      //   ],
                      // ),
                      SizedBox(height: 20,),

                      ElevatedButton(style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32), // <-- Radius
    ),
                              backgroundColor: Color(0Xff1B2E0D), elevation: 0,minimumSize:Size(330 , 60)),
                        onPressed: HandleSignIn,
                        child: Text('LOGIN',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily:GoogleFonts.inter().fontFamily),),
                      ),
                    ],
                  ),
                ),
              ),
              // if Signin is False
              Visibility(
                visible: !isSignInPage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  
                  children: [
                      Text('Client',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily:GoogleFonts.inter().fontFamily),),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('First Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        ],
                      ),

                    TextField(
                      controller: _FNameController,
                      decoration: const InputDecoration(
                        
                        hintText: 'Enter your Phone Number ',

                      ),
                    ),
                      Row(
                        children: [
                          Text('Last Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        ],
                      ),

                    TextField(
                      controller: _LNameController,
                      decoration: const InputDecoration(
                      
                        hintText: 'Enter your Phone Number ',

                      ),
                    ),
                      Row(
                        children: [
                          Text('Email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        ],
                      ),

                    TextField(
                      controller: _EmailController,
                      decoration: const InputDecoration(
                       
                        hintText: 'Enter your Phone Number ',

                      ),
                    ),
                      Row(
                        children: [
                          Text('Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        ],
                      ),

                    TextField(
                      controller: _PassWordController,
                      decoration: const InputDecoration(
                       
                        hintText: 'Enter your Phone Number ',

                      ),
                    ),
                      Row(
                        children: [
                          Text('Phone Number',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        ],
                      ),

                    TextField(
                      controller: _PhNumController,
                      decoration: const InputDecoration(
                       
                        hintText: 'Enter your Phone Number ',
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32), // <-- Radius
    ),
                              backgroundColor: Color(0Xff1B2E0D), elevation: 0,minimumSize:Size(330 , 60)),
                      onPressed: HandleSignUp,
                      
                      child: Text('SIGN UP',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily:GoogleFonts.inter().fontFamily,),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
