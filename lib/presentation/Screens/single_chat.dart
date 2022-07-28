// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configurations/Utils/Colors.dart';
import '../../configurations/Utils/res.dart';




class SingleChat extends StatelessWidget {
  const SingleChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar:
              Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: MyAppColors.appColor),
                            height: 40,
                            width: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(Res.cameraicon),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 40,
                              width: 240,
                              decoration: BoxDecoration(
                                  color: MyAppColors.Lightgrey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(23)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        Res.sendicon,
                                        // color: MyAppColors.appColor,
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(left: 15, top: 10),
                                    border: InputBorder.none,
                                    hintText: "Type a Message"),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ]),
            ),
          ]),
          body: Stack(children: [
            (SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    height: 5,
                    color: MyAppColors.Lightgrey,
                  ),
                  Container(
                    height: 700,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        //   shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (_, i) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 50,
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(33)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: SvgPicture.asset(
                                            Res.personicon,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                      decoration: const BoxDecoration(),
                                    ),
                                    BubbleNormal(
                                      text: 'bubble normal with tail',
                                      isSender: false,
                                      color: MyAppColors.Lightgrey.withOpacity(
                                          0.3),
                                      tail: true,
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        BubbleNormal(
                                          text: 'bubble normal with tail',
                                          isSender: false,
                                          color: MyAppColors.appColor,
                                          tail: false,
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Text("8:46",
                                              style: GoogleFonts.roboto(
                                                  // fontFamily: 'Gilroy',
                                                  color: MyAppColors.appColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            )),
            Positioned(
              child: Container(
                color: MyAppColors.whitecolor,
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Card(
                                //  color: MyAppColors.appColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 2,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 19,
                                    color: MyAppColors.appColor,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 55,
                            width: 55,
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(33)),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  Res.personicon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            decoration: const BoxDecoration(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pavel Woods",
                                  style: GoogleFonts.roboto(
                                      // fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              SizedBox(
                                height: 2,
                              ),
                              Text("is Typing",
                                  style: GoogleFonts.roboto(
                                      // fontFamily: 'Gilroy',
                                      color: MyAppColors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Res.audiocallingicon),
                          SizedBox(
                            width: 5,
                          ),
                          //  SvgPicture.asset(Res.videocallingicon)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
