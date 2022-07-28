// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../Infrastructure/Helpers/date_formatter.dart';
import '../../Infrastructure/Models/payement_Model.dart';
import '../../Infrastructure/Services/payement_services.dart';
import '../../configurations/Utils/Colors.dart';
import '../../configurations/Utils/res.dart';
import 'ReviewSection/feedback.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  PayementServices _payementServices = PayementServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamProvider.value(
          value: _payementServices
              .streamPaymenstHistory(FirebaseAuth.instance.currentUser!.uid),
          initialData: [PayementModel()],
          builder: (context, child) {
            List<PayementModel> _paymentList =
                context.watch<List<PayementModel>>();
            return Scaffold(
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
                        SizedBox(
                          width: 45,
                        ),
                        Text("Payment History",
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
                  //   child: Container(
                  //     height: 50,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         color: MyAppColors.bgtextfieldcolor,
                  //         borderRadius: BorderRadius.circular(13)),
                  //     child: TextFormField(
                  //       decoration: InputDecoration(
                  //           contentPadding:
                  //               const EdgeInsets.only(left: 25, top: 15),
                  //           hintText: "Search here..",
                  //           hintStyle: GoogleFonts.roboto(
                  //               // fontFamily: 'Gilroy',
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 16),
                  //           prefixIcon: Padding(
                  //             padding: const EdgeInsets.all(13.0),
                  //             child: SvgPicture.asset(
                  //               Res.searchicon,
                  //               height: 2,
                  //               width: 2,
                  //             ),
                  //           ),
                  //           border: InputBorder.none),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 1,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _paymentList.length,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            _paymentList[i]
                                                        .user!
                                                        .userImage
                                                        .toString() ==
                                                    null
                                                ? CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage: AssetImage(
                                                        Res.invitefriendbanner),
                                                  )
                                                : CachedNetworkImage(
                                                    height: 42,
                                                    width: 50,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                          width: 42.0,
                                                          height: 42.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        33),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                    imageUrl: _paymentList[i]
                                                        .user!
                                                        .userImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        SpinKitWave(
                                                            color: MyAppColors
                                                                .appColor,
                                                            size: 30,
                                                            type:
                                                                SpinKitWaveType
                                                                    .start),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error))
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                _paymentList[i]
                                                    .user!
                                                    .fullName
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                    // fontFamily: 'Gilroy',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                DateFormatter.dateFormatter(
                                                    _paymentList[i]
                                                        .payementDate!
                                                        .toDate()),
                                                style: GoogleFonts.roboto(
                                                    // fontFamily: 'Gilroy',
                                                    color:
                                                        MyAppColors.Lightgrey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "\$" +
                                                  _paymentList[i]
                                                      .payementAmount
                                                      .toString(),
                                              style: GoogleFonts.roboto(
                                                  // fontFamily: 'Gilroy',
                                                  color: MyAppColors.redcolor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15)),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  height: 3,
                                  color: MyAppColors.Lightgrey,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ));
          }),
    );
  }
}
