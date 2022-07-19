// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/Services/auth_services.dart';
import 'package:digirental_shop_app/Services/user_services.dart';
import 'package:digirental_shop_app/UI/Screens/payment_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/user_model.dart';
import '../../Utils/Colors.dart';
import '../../Utils/res.dart';
import 'AuthSection/login_screen.dart';
import 'invite_friends.dart';
import 'my_profile.dart';
import 'my_reviews.dart';

class Account extends StatelessWidget {
  const Account(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserServices userServices = UserServices();
    AuthServices authServices = AuthServices();

    return StreamProvider.value(
        value: userServices
            .fetchUserRecord(FirebaseAuth.instance.currentUser!.uid),
        initialData: UserModel(),
        builder: (context, child) {
          UserModel model = context.watch<UserModel>();
          return (Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                model.userImage == null
                                    ? CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage(Res.personicon),
                                      )
                                    : CachedNetworkImage(
                                        height: 80,
                                        width: 80,
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            Container(
                                              width: 80.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                        imageUrl: model.userImage.toString(),
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            SpinKitWave(
                                                color: MyAppColors.appColor,
                                                size: 30,
                                                type: SpinKitWaveType.start),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error))
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(model.fullName.toString(),
                                    style: GoogleFonts.roboto(
                                        // fontFamily: 'Gilroy',
                                        //color: MyAppColors.blue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(model.userEmail.toString(),
                                    style: GoogleFonts.roboto(
                                        // fontFamily: 'Gilroy',
                                        color: MyAppColors.Lightgrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15)),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(MyProfileScreen());
                                  },
                                  child: Container(
                                    height: 43,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: MyAppColors.appColor,
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: Center(
                                      child: Text("View Profile",
                                          style: GoogleFonts.roboto(
                                              // fontFamily: 'Gilroy',
                                              color: MyAppColors.whitecolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15)),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        // Padding(
                        //     padding: const EdgeInsets.only(bottom: 48.0),
                        //     child: SvgPicture.asset(Res.settings))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: MyAppColors.blue),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 80,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Card(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(13)),
                        //     elevation: 2,
                        //     child: Padding(
                        //       padding:
                        //           const EdgeInsets.symmetric(horizontal: 20),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               CircleAvatar(
                        //                 radius: 25,
                        //                 backgroundColor: MyAppColors.appColor
                        //                     .withOpacity(0.1),
                        //                 child: SvgPicture.asset(
                        //                     Res.postedproducts),
                        //               ),
                        //               const SizedBox(
                        //                 width: 15,
                        //               ),
                        //               Text("My Posted Products",
                        //                   style: GoogleFonts.roboto(
                        //                       // fontFamily: 'Gilroy',
                        //                       color: Colors.black,
                        //                       fontWeight: FontWeight.w600,
                        //                       fontSize: 17)),
                        //             ],
                        //           ),
                        //           SvgPicture.asset(Res.arrowforward)
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 85,
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Get.to(PaymentHistory());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              elevation: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: MyAppColors.appColor
                                              .withOpacity(0.1),
                                          child: SvgPicture.asset(
                                              Res.paymenthistory),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text("Payment History",
                                            style: GoogleFonts.roboto(
                                                // fontFamily: 'Gilroy',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17)),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      Res.arrowforward,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            elevation: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: MyAppColors.appColor
                                            .withOpacity(0.1),
                                        child: SvgPicture.asset(
                                            Res.notificationsettings),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text("Notifications",
                                          style: GoogleFonts.roboto(
                                              // fontFamily: 'Gilroy',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                    ],
                                  ),
                                  SvgPicture.asset(Res.arrowforward)
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            elevation: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: MyAppColors.appColor
                                            .withOpacity(0.1),
                                        child: SvgPicture.asset(Res.mylist),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text("My Orders",
                                          style: GoogleFonts.roboto(
                                              // fontFamily: 'Gilroy',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                    ],
                                  ),
                                  SvgPicture.asset(Res.arrowforward)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              Get.to(Myreviews());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              elevation: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: MyAppColors.appColor
                                              .withOpacity(0.1),
                                          child: SvgPicture.asset(Res.mylist),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text("My Reviews",
                                            style: GoogleFonts.roboto(
                                                // fontFamily: 'Gilroy',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17)),
                                      ],
                                    ),
                                    SvgPicture.asset(Res.arrowforward)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              Get.to(InviteFriends());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              elevation: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: MyAppColors.appColor
                                              .withOpacity(0.1),
                                          child: SvgPicture.asset(
                                              Res.invitefireinds),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text("Invite Friends",
                                            style: GoogleFonts.roboto(
                                                // fontFamily: 'Gilroy',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17)),
                                      ],
                                    ),
                                    SvgPicture.asset(Res.arrowforward)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {

                              authServices.signOut().whenComplete(() async {
                                {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.remove("token");
                                  Fluttertoast.showToast(
                                      msg: "Logout Sucessfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });

                              Get.to(LoginScreen());
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              elevation: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: MyAppColors.redcolor
                                              .withOpacity(0.1),
                                          child: SvgPicture.asset(Res.logout),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text("LogOut",
                                            style: GoogleFonts.roboto(
                                                // fontFamily: 'Gilroy',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17)),
                                      ],
                                    ),
                                    SvgPicture.asset(Res.arrowforward)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )));
        });
  }
}
