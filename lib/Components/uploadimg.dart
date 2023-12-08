// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// class uploadimg extends StatefulWidget {
//   const uploadimg({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<uploadimg> createState() => _uploadimgState();
// }

// class _uploadimgState extends State<uploadimg> {


//   Future pickImageC() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);

//       if (image == null) return;

//       final imageTemp = File(image.path);

//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Image Picker Example"),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               ElevatedButton(onPressed: pickImage, child: const Text('og')),
//               MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Gallery",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     pickImage();
//                   }),
//               MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Camera",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     pickImageC();
//                   }),
//               const SizedBox(
//                 height: 20,
//               ),
//               image != null
//                   ? Image.file(image!)
//                   : const Text("No image selected")
//             ],
//           ),
//         ));
//   }
// }
