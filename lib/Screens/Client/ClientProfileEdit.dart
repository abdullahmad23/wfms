import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/AppLogo.dart';

class ClientProfileEdit extends StatefulWidget {
  const ClientProfileEdit({Key? key}) : super(key: key);

  @override
  State<ClientProfileEdit> createState() => _ClientProfileEditState();
}

class _ClientProfileEditState extends State<ClientProfileEdit> {

  TextEditingController _updateNameController = TextEditingController();
  TextEditingController _updateAddressController = TextEditingController();
  TextEditingController _updatePhoneNoController = TextEditingController();

  UpdateProfiledetail(){

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             IconButton(
                 onPressed: (){
                   Navigator.pop(context);
                 },
                 icon: Icon(Icons.arrow_back_ios,size: 18,color: Color(0xff7FBD50),)),

              Text('My Profile', style:TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color:Color(0xff7FBD50))),

              ElevatedButton(
                onPressed: UpdateProfiledetail,
                child: Text('Save',style: TextStyle(fontSize: 15.0, color:Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7FBD50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color(0xff1D331B),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail_outline_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'email',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                      )),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 - 50,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://i0.wp.com/newdoorfiji.com/wp-content/uploads/2018/03/profile-img-1.jpg?ssl=1"),
                      ),
                    ),
                  ),
                ],
              ),

              // ================= ============== =====================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: GoogleFonts.inter().fontFamily),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text('Name',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _updateNameController,
                          decoration: const InputDecoration(
                            hintText: 'old Name',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name field Not be empty";
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        Text('Address',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _updateAddressController,
                          decoration: const InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address field Not be empty";
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        Text('Phone',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: _updatePhoneNoController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Phone',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone field Not be empty";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // =============== ==================== ================
            ]),
          ),
        ],
      ),
    );
  }
}
