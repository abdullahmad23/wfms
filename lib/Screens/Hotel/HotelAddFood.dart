import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste/Components/AppLogo.dart';
import 'package:intl/intl.dart';

class HotelAddFood extends StatefulWidget {
  const HotelAddFood({super.key});

  @override
  State<HotelAddFood> createState() => _HotelAddFoodState();
}

class _HotelAddFoodState extends State<HotelAddFood> {
  String Imgurl = '';
  File? image;
  DateTime selectedDate = DateTime.now();
  TextEditingController _foodNameController = TextEditingController();
  TextEditingController _foodQuantityController = TextEditingController();
  TextEditingController _foodExpiryController = TextEditingController();
  TextEditingController _foodPriceController = TextEditingController();

  void uploadProduct() {
    String id = FirebaseAuth.instance.currentUser!.uid;
    uploadFileToFirebase(image!).then((value) {
      Map<String, dynamic> Data = {
        'Title': _foodNameController.text,
        'Qty': _foodQuantityController.text,
        'Price': _foodPriceController.text,
        'Exp': _foodExpiryController.text,
        'img': Imgurl,
        'Created_By': id,
      };
      FirebaseFirestore.instance
          .collection('Food')
          .add(Data)
          .then((value) => null);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _foodExpiryController.text = '';
  }

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

  Future<void> uploadFileToFirebase(File file) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('Food/${basename(file.path)}');
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print('File uploaded successfully. Download URL: $downloadURL');
      setState(() {
        Imgurl = downloadURL;
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppLogo(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: pickImage,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/imgplaceholder.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Food Name ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                    controller: _foodNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Food quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Food quantity ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                    controller: _foodQuantityController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Food Expiry Date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          print(selectedDate);
                          _foodExpiryController.text =
                              "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString()}";
                        });
                      }
                      ;
                    },
                    decoration: InputDecoration(
                        // hintText: 'Enter Expiry Date ',
                        // hintStyle: TextStyle(
                        //   fontSize: 12,
                        //   fontFamily: GoogleFonts.inter().fontFamily,
                        //   color: Colors.black45,
                        // ),
                        ),
                    controller: _foodExpiryController,
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Food Per/Kg Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Per/Kg Price ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.black45,
                      ),
                    ),
                    controller: _foodPriceController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32), // <-- Radius
                        ),
                        backgroundColor: const Color(0Xff1B2E0D),
                        elevation: 0,
                        minimumSize: const Size(330, 60)),
                    onPressed: uploadProduct,
                    child: Text(
                      'Upload',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
