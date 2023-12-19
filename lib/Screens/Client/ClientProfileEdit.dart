import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste/Screens/Client/ClientProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Components/AppLogo.dart';

class ClientProfileEdit extends StatefulWidget {
  const ClientProfileEdit({Key? key}) : super(key: key);

  @override
  State<ClientProfileEdit> createState() => _ClientProfileEditState();
}

class _ClientProfileEditState extends State<ClientProfileEdit> {
  String Imgurl = '';

  final TextEditingController _updateNameController = TextEditingController();
  final TextEditingController _updateAddressController =
      TextEditingController();
  final TextEditingController _updatePhoneNoController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Map<String, dynamic> UserDetails = {};
  bool isLoading = true;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  uploadFileToFirebase(File file) async {
    EasyLoading.show(status: "please wait...");
    try {
      await FirebaseStorage.instance
          .ref()
          .child('ProfileImage/${path.basename(file.path)}')
          .putFile(file)
          .whenComplete(() {})
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          try {
            String UserId = FirebaseAuth.instance.currentUser!.uid;
            FirebaseFirestore.instance.collection('users').doc(UserId).update({
              "name": _updateNameController.text,
              "phone": _updatePhoneNoController.text,
              "img": value,
              "address": _updateAddressController.text,
            }).then((value) {
              print('updated');

              EasyLoading.dismiss();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientProfile()));
            });
          } on FirebaseException catch (e) {
            EasyLoading.showError(e.code);
          } catch (e) {
            EasyLoading.showError(e.toString());
          }
        });
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _updateNameController.text = '';
    _updateAddressController.text = '';
    _updatePhoneNoController.text = '';

    getUserData();
  }

  UpdateProfiledetail() {
    EasyLoading.dismiss();

    if (_formkey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait...');

      uploadFileToFirebase(image!).then((value) {
        print(value);
      });
    } else {
      print('object');
    }
  }

  getUserData() {
    try {
      String UserId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance
          .collection('users')
          .doc(UserId)
          .get()
          .then((userDetails) {
        setState(() {
          UserDetails = userDetails.data()!;
          Imgurl = UserDetails['img'];
          _updateNameController.text = UserDetails['name'];
          _updatePhoneNoController.text = UserDetails['phone'];
          _updateAddressController.text = userDetails['address'];

          isLoading = false;
        });
      });
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.code);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: Color(0xff7FBD50),
                            )),
                        const Text('My Profile',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff7FBD50))),
                        ElevatedButton(
                          onPressed: UpdateProfiledetail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff7FBD50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Color(0xff1D331B),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: pickImage,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff7FBD50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Edit Image',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  bottom: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 20,
                                  )),
                              Positioned(
                                right:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: image != null
                                        ? Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            UserDetails['img'],
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ================= ============== =====================
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: GoogleFonts.inter()
                                                    .fontFamily),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      const Text('Name',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700)),
                                      TextFormField(
                                        controller: _updateNameController,
                                        decoration: const InputDecoration(

                                            // hintText: ,
                                            // hintStyle: TextStyle(fontSize: 12),
                                            ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Name field Not be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15.0),
                                      const Text('Address',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700)),
                                      TextFormField(
                                        controller: _updateAddressController,
                                        decoration: const InputDecoration(
                                          hintText: 'Address',
                                          hintStyle: TextStyle(fontSize: 12),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Address field Not be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15.0),
                                      const Text('Phone',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700)),
                                      TextFormField(
                                        controller: _updatePhoneNoController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: 'Phone',
                                          hintStyle: TextStyle(fontSize: 12),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Phone field Not be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // =============== ==================== ================
                        ]),
                  ),
                ],
              ),
            ),
          );
  }
}
