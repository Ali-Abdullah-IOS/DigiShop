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

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                          Text("Reset Password",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Please Enter your new password below",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
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
                      headingtext: "New Password",
                      onPwdTap: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      visible: isvisible,
                      isPasswordField: true,
                      suffixIcon2: Icons.visibility_off,
                      suffixIcon: Res.passwordicon,
                      maxlength: 20,
                      keyboardtype: TextInputType.text,
                      authcontroller: _emailController,
                      showImage: false,
                      showsuffix: false,
                      showpassoricon: false,
                      suffixImage: Res.personicon,
                      text: "Enter Password",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter more than 6 digit password";
                        } else if (value.length < 6)
                          return "Please Enter atleast 6 password";
                        return null;
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: authtextfieldWidget(
                      headingtext: "Confirm New Password",
                      onPwdTap: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      visible: isvisible,
                      isPasswordField: true,
                      suffixIcon2: Icons.visibility_off,
                      suffixIcon: Res.passwordicon,
                      maxlength: 20,
                      keyboardtype: TextInputType.text,
                      authcontroller: _emailController,
                      showImage: false,
                      showsuffix: false,
                      showpassoricon: false,
                      suffixImage: Res.personicon,
                      text: "Enter Password Again",
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
                    //   Get.to(const Bottomnavigation());
                  },
                  containerheight: 55,
                  text: "Create New Password",
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
