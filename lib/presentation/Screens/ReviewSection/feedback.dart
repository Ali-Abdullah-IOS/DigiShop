// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';


import 'package:digirental_shop_app/presentation/Screens/ChatSection/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../Infrastructure/Helpers/BottomNavBar.dart';
import '../../../Infrastructure/Helpers/helper.dart';
import '../../../Infrastructure/Models/Review_Model.dart';
import '../../../Infrastructure/Services/review_services.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../Widgets/appbutton.dart';
import '../../Widgets/auth_textfield_widget.dart';

class FeedbackScreen extends StatefulWidget {
  String userId;

  FeedbackScreen({required this.userId});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  ReviewServices _reviewServices = ReviewServices();

  // AuthServices authServices = AuthServices();
  // UserServices userServices = UserServices();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  File? _file;
  bool isChecked = false;

  // late final _ratingController;
  // late double _rating;
  //
  // double _userRating = 3.0;
  // int _ratingBarMode = 1;
  num? _ratingValueservice;
  num? _ratingValuerecommend;
  double _initialRating = 2.0;

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
    var user = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              onTap: () {
                _reviewServices
                    .createReview(ReviewModel(
                        userId: getUserID(),
                        experiencedesc: _experienceController.text,
                        servicerating:
                            num.parse(_ratingValueservice.toString()),
                        recommedrating:
                            num.parse(_ratingValuerecommend.toString()),
                        ownerId: widget.userId,
                        user: user.getUserDetails()

                        // payementAmount:
                        //     num.parse(paymentIntentData!['amount'].toString()),
                        // userId: getUserID(),
                        //  paymentDate:

                        //  shopID: getUserID()
                        ))
                    .then((value) {
                  Fluttertoast.showToast(msg: "FeedBack Submitted");
                });
                //  _signUpUser(context);
                //   Get.to(const Bottomnavigation());
              },
              containerheight: 55,
              text: "Submit Feedback",
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(Bottomnavigation(
                          index: 3,
                        ));
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
                    SizedBox(
                      width: 75,
                    ),
                    Text("Feedback",
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 19)),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: SizedBox(
              //     height: 85,
              //     width: double.infinity,
              //     child: InkWell(
              //       onTap: () {
              //         Get.to(PaymentHistory());
              //       },
              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(13)),
              //         elevation: 4,
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(
              //                 children: [
              //                   CircleAvatar(
              //                     radius: 25,
              //                     backgroundColor:
              //                         MyAppColors.appColor.withOpacity(0.1),
              //                     child: SvgPicture.asset(Res.personicon),
              //                   ),
              //                   const SizedBox(
              //                     width: 10,
              //                   ),
              //                   Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Row(
              //                         children: [
              //                           Text("Dial Criage (5+ Years)",
              //                               style: GoogleFonts.roboto(
              //                                   // fontFamily: 'Gilroy',
              //                                   //color: MyAppColors.blue,
              //                                   fontWeight: FontWeight.w600,
              //                                   fontSize: 16)),
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Row(
              //                         children: [
              //                           RatingBar.builder(
              //                             itemSize: 17,
              //                             initialRating: 3,
              //                             minRating: 1,
              //                             direction: Axis.horizontal,
              //                             allowHalfRating: true,
              //                             itemCount: 5,
              //                             itemPadding: EdgeInsets.symmetric(
              //                                 horizontal: 0.0),
              //                             itemBuilder: (context, _) => Icon(
              //                               Icons.star,
              //                               color: Colors.amber,
              //                             ),
              //                             onRatingUpdate: (rating) {
              //                               print(rating);
              //                             },
              //                           ),
              //                           Text(" 4.9 (206 Reviews)",
              //                               style: GoogleFonts.roboto(
              //                                   // fontFamily: 'Gilroy',
              //                                   color: Colors.grey,
              //                                   fontWeight: FontWeight.w400,
              //                                   fontSize: 13)),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              //     ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Service",
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 17)),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    RatingBar.builder(
                        itemSize: 40,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValueservice = value;
                          });
                        }),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                        _ratingValueservice == null
                            ? "0.0"
                            : _ratingValueservice.toString(),
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            color: Colors.amber,
                            fontWeight: FontWeight.w400,
                            fontSize: 33)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Hire again or Recommended",
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 17)),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 40,
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValuerecommend = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                        _ratingValuerecommend == null
                            ? "0.0"
                            : _ratingValuerecommend.toString(),
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            color: Colors.amber,
                            fontWeight: FontWeight.w400,
                            fontSize: 33)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Write Experience with seller",
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 17)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  height: 130,
                  width: double.infinity,
                  child: TextFormField(
                    controller: _experienceController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: "Type Here...",
                        border: InputBorder.none),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
