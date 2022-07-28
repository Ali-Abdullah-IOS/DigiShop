import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/presentation/Screens/AuthSection/update_profile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Infrastructure/Helpers/BottomNavBar.dart';
import '../../../Infrastructure/Models/user_model.dart';
import '../../../Infrastructure/Services/user_services.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../../configurations/Utils/res.dart';
import '../../Widgets/appbutton.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyAppColors.appColor,
        body: StreamProvider.value(
            value: _userServices
                .fetchUserRecord(FirebaseAuth.instance.currentUser!.uid),
            initialData: UserModel(),
            builder: (context, child) {
              UserModel model = context.watch<UserModel>();
              return Column(children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(Bottomnavigation(index: 4,));
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Center(
                                child: SvgPicture.asset(Res.arrowbackgreen)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text("My Profile",
                          style: GoogleFonts.roboto(
                              // fontFamily: 'Gilroy',
                              color: MyAppColors.whitecolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                    ],
                  ),
                ),
                Spacer(),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 550,
                      width: double.infinity,
                      color: MyAppColors.whitecolor,
                      child: Column(
                        children: [
                          SizedBox(height: 70),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: MyAppColors
                                                .appColor
                                                .withOpacity(0.1),
                                            child: SvgPicture.asset(
                                                Res.personicon),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 13,
                                              ),
                                              Text("Full Name",
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(model.fullName.toString(),
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: MyAppColors
                                                .appColor
                                                .withOpacity(0.1),
                                            child:
                                                SvgPicture.asset(Res.emailicon),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 13,
                                              ),
                                              Text("Email",
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(model.userEmail.toString(),
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: MyAppColors
                                                .appColor
                                                .withOpacity(0.1),
                                            child:
                                                SvgPicture.asset(Res.phoneicon),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 13,
                                              ),
                                              Text("Phone Number",
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(model.PhoneNumber.toString(),
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: MyAppColors
                                                .appColor
                                                .withOpacity(0.1),
                                            child: SvgPicture.asset(
                                                Res.locationicon),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 13,
                                              ),
                                              Text("Address",
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("Kohat KDA",
                                                  style: GoogleFonts.roboto(
                                                      // fontFamily: 'Gilroy',
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          AppButton(
                            onTap: () {
                              Get.to(UpdateProfileScreen(
                                userId: model.userID.toString(),
                                image: model.userImage.toString(),
                                fullName: model.fullName.toString(),
                                phoneNumber: model.PhoneNumber.toString(),
                              ));
                            },
                            containerheight: 55,
                            text: "Update Profile",
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -60,
                      left: 120,
                      child: Stack(
                        children: [
                          model.userImage == null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(Res.personicon),
                                )
                              : CachedNetworkImage(
                                  height: 110,
                                  width: 110,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: 110.0,
                                        height: 110.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  imageUrl: model.userImage.toString(),
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          SpinKitWave(
                                              color: MyAppColors.appColor,
                                              type: SpinKitWaveType.start),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error))
                        ],
                      ),
                    )
                  ],
                )
              ]);
            }));
  }
}
