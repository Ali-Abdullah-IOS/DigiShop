import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Infrastructure/Services/product_services.dart';
import '../../configurations/Utils/Colors.dart';



class ProductDeleteConfirmDialog extends StatefulWidget {
  final String productID;

  ProductDeleteConfirmDialog(this.productID);

  @override
  _ProductDeleteConfirmDialogState createState() =>
      _ProductDeleteConfirmDialogState();
}

class _ProductDeleteConfirmDialogState
    extends State<ProductDeleteConfirmDialog> {
  bool isLoading = false;
  ProductServices _productServices = ProductServices();

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
                  Text("Product?",
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
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return SpinKitWave(
                                color: MyAppColors.appColor,
                                type: SpinKitWaveType.start);
                          });

                      _productServices
                          .deleteProduct(widget.productID)
                          .whenComplete(() => Navigator.pop(context));
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
    );
  }
}
