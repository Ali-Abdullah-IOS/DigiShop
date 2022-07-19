import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Colors.dart';

class AuthTextField extends StatelessWidget {
  final String label;

  final String hinttext;
  final TextInputType keyboard;
  final double letterSpacing;
  final bool showSuffix;
  final VoidCallback onEditingComplete;
  final TextEditingController controller;
  final Function(String) validator;

  AuthTextField(
      {required this.label,
      required this.keyboard,
      required this.hinttext,
      this.letterSpacing = 0.3,
      required this.validator,
      required this.controller,
      this.showSuffix = false,
      required this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyAppColors.bgtextfieldcolor),
          height: 48,
          width: 330,
          child: TextFormField(
            keyboardType: keyboard,
            validator: (val) => validator(val!),
            // controller: controller,
            // onEditingComplete: () => onEditingComplete(),
            // style: TextStyle(
            //     fontWeight: FontWeight.w600,
            //     letterSpacing: letterSpacing,
            //     fontFamily: "Inter",
            //     fontSize: 16,
            //     color: Colors.black),
            decoration: InputDecoration(
              //labelText: "Name",
              errorStyle: TextStyle(color: Colors.red),
              contentPadding: EdgeInsets.only(left: 25, top: 12),
              hintText: hinttext,
              suffixIcon: showSuffix ? Image.asset("Assets/name.png") : null,
              border: InputBorder.none,
              hintStyle: GoogleFonts.roboto(
                  // fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}

//  Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: MyAppColors.bgtextfieldcolor),
//                       height: 48,
//                       width: 330,
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                             contentPadding:
//                                 EdgeInsets.only(left: 25, top: 12),
//                             hintText: "John Doe",
//                             hintStyle: GoogleFonts.roboto(
//                                 // fontFamily: 'Gilroy',
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                             suffixIcon: Image.asset("Assets/name.png"),
//                             border: InputBorder.none),
//                       ),
//                     )
