// ignore_for_file: use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Infrastructure/Services/shop_services.dart';
import '../../configurations/Utils/Colors.dart';



class ShopDeleteConfirmDialog extends StatefulWidget {
  final String shopID;

  ShopDeleteConfirmDialog(this.shopID);

  @override
  _ShopDeleteConfirmDialogState createState() =>
      _ShopDeleteConfirmDialogState();
}

class _ShopDeleteConfirmDialogState extends State<ShopDeleteConfirmDialog> {
  AddShopServices _addShopServices = AddShopServices();
  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //  ContactServices _contactServices = ContactServices();
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: SpinKitWave(color: MyAppColors.appColor),
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.0)), //this right here
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Show Confirm",
                        style: GoogleFonts.poppins(
                            color: MyAppColors.blackcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    // Text("Shop?",
                    //     style: GoogleFonts.poppins(
                    //         color: MyAppColors.blackcolor,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Text("Cancel",
                    //       style: GoogleFonts.poppins(
                    //           color: MyAppColors.blackcolor,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 17)),
                    // ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      color: MyAppColors.appColor,
                      height: 20,
                      width: 3,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     // showDialog(
                    //     //     context: context,
                    //     //     barrierDismissible: false,
                    //     //     builder: (BuildContext context) {
                    //     //       return SpinKitWave(
                    //     //           color: MyAppColors.appColor,
                    //     //           type: SpinKitWaveType.start);
                    //     //     });
                    //     //   makeLoadingTrue();
                    //     //
                    //     //   _addShopServices
                    //     //       .deleteshop(widget.shopID)
                    //     //       .
                    //     //       //  makeLoadingFalse()
                    //     //       whenComplete(() => Get.back());
                    //     // },
                    //   },
                    //   child: Text("Delete",
                    //       style: GoogleFonts.poppins(
                    //           color: MyAppColors.blackcolor,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 17)),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
