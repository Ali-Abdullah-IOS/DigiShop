// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../Infrastructure/Helpers/OnBoarding1.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../../configurations/Utils/res.dart';
import 'CreateAccount.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 3), () => Get.to(OnBoardingPage()));
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("token");
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyAppColors.appColor,
        body: Center(
          child: SvgPicture.asset(Res.logowhite),
        ));
  }
}
