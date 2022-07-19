// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Colors.dart';

import '../../Utils/res.dart';
import '../Widgets/appbutton.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child:
                          Center(child: SvgPicture.asset(Res.arrowbackgreen)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                Text("Invite Friends",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.blackcolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset(Res.invitefriendbanner)],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: GoogleFonts.roboto(
                      //fontFamily: 'Gilroy',
                      color: MyAppColors.blackcolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  text:
                      "Lorem ipsum doh eam rper sapien nibh eu nulla platea. Aliquam ipsum,"),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AppButton(
              onTap: () {
                share();
              },
              containerheight: 55,
              text: "Share With Friends",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'DigiRental App',
        text: 'Rent anything with digirental ',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'DigiRental App');
  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
    });
  }
}
