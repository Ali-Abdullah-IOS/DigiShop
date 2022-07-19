// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_final_fields

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Models/user_model.dart';
import '../../../Services/auth_services.dart';
import '../../../Services/user_services.dart';
import '../../../Utils/Colors.dart';

import '../../../Utils/res.dart';
import '../../Widgets/appbutton.dart';
import '../../../Helpers/BottomNavBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Widgets/auth_textfield_widget.dart';

class OtpVerfication extends StatefulWidget {
  const OtpVerfication({Key? key}) : super(key: key);

  @override
  _OtpVerficationState createState() => _OtpVerficationState();
}

class _OtpVerficationState extends State<OtpVerfication> {
  AuthServices authServices = AuthServices();
  UserServices userServices = UserServices();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  File? _file;
  bool isChecked = false;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final spinkit = SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
  bool isLoadingspin = true;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: SpinKitWave(
        color: MyAppColors.appColor,
      ),
      child: Scaffold(
        backgroundColor: MyAppColors.bgcolor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset(Res.logogreen)],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("OTP Verification",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("we have send an OTP code to your mobile",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          Text("Please enter that code below to verify",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: authtextfieldWidget(
                      headingtext: "Enter OTP",
                      onPwdTap: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      visible: isvisible,
                      isPasswordField: true,
                      suffixIcon2: Icons.visibility_off,
                      suffixIcon: Res.otpicon,
                      maxlength: 20,
                      keyboardtype: TextInputType.text,
                      authcontroller: _emailController,
                      showImage: false,
                      showsuffix: false,
                      showpassoricon: false,
                      suffixImage: Res.personicon,
                      text: "Enter your OTP code here",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter more than 6 digit password";
                        } else if (value.length < 6)
                          return "Please Enter atleast 6 password";
                        return null;
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 25,
                ),
                AppButton(
                  onTap: () {
                    Get.to(Bottomnavigation(
                      index: 0,
                    ));
                  },
                  containerheight: 55,
                  text: "Verify",
                ),
                const SizedBox(
                  height: 13,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
