// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../UI/Screens/welcome_screen.dart';
import '../Utils/Colors.dart';
import '../Utils/res.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
    );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      //  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            //  child: _buildImage('flutter.png', 100),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: "DigiUserRental",
          body:
              "We are units transfer agency which helps the client to transfer their units with each other.",
          image: Padding(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
            child: SvgPicture.asset("assets/Images/manageshops.png"),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "EasyPaisa Payement",
          body: "Quickly Transfer units safely to friends and family.",
          image: Padding(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
            child: SvgPicture.asset("assets/Images/manageshops.png"),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Digital Renting",
          body: "Quickly Transfer units safely to friends and family.",
          image: Padding(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
            child: SvgPicture.asset("assets/Images/manageshops.png"),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Make Renting Better",
          body: "Quickly Transfer units safely to friends and family.",
          image: Padding(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
            child: SvgPicture.asset("assets/Images/manageshops.png"),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      dotsFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: Padding(
        padding: const EdgeInsets.only(right: 100),
        child: const Text(
          'Skip',
          style: TextStyle(color: MyAppColors.appColor),
        ),
      ),
      next: const Icon(Icons.arrow_forward, color: MyAppColors.appColor),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: MyAppColors.appColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: MyAppColors.appColor,
        activeColor: MyAppColors.appColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
