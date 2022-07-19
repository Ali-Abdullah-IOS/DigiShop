import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';


import '../../Services/category_services.dart';
import '../../Utils/Colors.dart';
import '../../Utils/res.dart';

class CategoryDeleteConfirmWidget extends StatefulWidget {
  final String categoryID;

  CategoryDeleteConfirmWidget(this.categoryID);

  @override
  _CategoryDeleteConfirmWidgetState createState() =>
      _CategoryDeleteConfirmWidgetState();
}

class _CategoryDeleteConfirmWidgetState
    extends State<CategoryDeleteConfirmWidget> {
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
    CategoryServices categoryServices = CategoryServices();
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
                    Text("Are you sure to delete this",
                        style: GoogleFonts.poppins(
                            color: MyAppColors.blackcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text("Category?",
                        style: GoogleFonts.poppins(
                            color: MyAppColors.blackcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",
                          style: GoogleFonts.poppins(
                              color: MyAppColors.blackcolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ),
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
                    InkWell(
                      onTap: () {
                        // showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (BuildContext context) {
                        //       return SpinKitWave(
                        //           color: MyAppColors.appColor,
                        //           type: SpinKitWaveType.start);
                        //     });
                        makeLoadingTrue();
                        categoryServices
                            .deleteCatgory(widget.categoryID)
                            .whenComplete(() => Get.back());
                      },
                      child: Text("Delete",
                          style: GoogleFonts.poppins(
                              color: MyAppColors.blackcolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ),
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
