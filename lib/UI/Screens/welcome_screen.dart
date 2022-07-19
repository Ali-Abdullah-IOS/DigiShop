// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Colors.dart';

import '../../Utils/res.dart';
import '../Widgets/appbutton.dart';
import 'AuthSection/CreateAccount.dart';
import 'AuthSection/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppColors.appColor,
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            SvgPicture.asset(
              Res.logowhite,
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text("DigiShop",
                style: GoogleFonts.roboto(
                    //fontFamily: 'Gilroy',
                    color: MyAppColors.whitecolor,
                    fontWeight: FontWeight.w700,
                    fontSize: 27)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: GoogleFonts.roboto(
                        //fontFamily: 'Gilroy',
                        color: MyAppColors.whitecolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    text:
                        "Lorem ipsum dolor sit amet,  adipiscing elit. Blandit lobortis diam arcu a vulputate. Egestas porta dictum id nulla. Risus ullamcorper sapien nibh eu nulla platea. Aliquam ipsum, consectetur adipiscing elit. Blandit lobortis diam arcu a vulputate. Egestas porta dictum id nulla. Risus ullamcorper sapien nibh eu nulla platea. Aliquam ipsum,"),
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: MyAppColors.whitecolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: 270,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 65,
                  ),
                  // AppButton(
                  //   onTap: () {
                  //     //  _signUpUser(context);
                  //     //   Get.to(const Bottomnavigation());
                  //   },
                  //   text: "Continue as a Guest",
                  //   backgroundColor: MyAppColors.Lightgrey,
                  //   containerheight: 55,
                  // ),
                  // SizedBox(
                  //   height: 18,
                  // ),
                  AppButton(
                    onTap: () {
                      //  _signUpUser(context);
                      Get.to(LoginScreen());
                    },
                    text: "Login",
                    textColor: MyAppColors.appColor,
                    showborder: true,
                    backgroundColor: MyAppColors.whitecolor,
                    containerheight: 55,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  AppButton(
                    onTap: () {
                      Get.to(CreateAccount());
                    },
                    text: "Create Account",
                    textColor: MyAppColors.whitecolor,
                    showborder: true,
                    backgroundColor: MyAppColors.appColor,
                    containerheight: 55,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
