import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/configurations/Utils/Colors.dart';
import 'package:digirental_shop_app/presentation/Widgets/appbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SmartContract extends StatefulWidget {
  String orderID;
  String buyerName;
  String buyeremail;
  String buyerimage;

  String SellerName;
  String SellerEmail;
  String sellerImage;

  String productName;
  String productAmount;
  String productQuanity;
  String ProductImage;
  String totalAmount;

  SmartContract(
      {required this.orderID,
      required this.buyerName,
      required this.buyeremail,
      required this.buyerimage,
      required this.SellerName,
      required this.SellerEmail,
      required this.sellerImage,
      required this.productName,
      required this.productAmount,
      required this.productQuanity,
      required this.ProductImage,
      required this.totalAmount});

  @override
  State<SmartContract> createState() => _SmartContractState();
}

class _SmartContractState extends State<SmartContract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Text("Smart Order Contract Details",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                Text("",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Buyer Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
                height: 65,
                width: 65,
                imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: widget.buyerimage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SpinKitWave(
                        color: MyAppColors.appColor,
                        size: 30,
                        type: SpinKitWaveType.start),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Buyer Name",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.buyerName,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Buyer Email",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.buyeremail,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Seller Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
                height: 65,
                width: 65,
                imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: widget.sellerImage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SpinKitWave(
                        color: MyAppColors.appColor,
                        size: 30,
                        type: SpinKitWaveType.start),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Seller Name",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.SellerName,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Seller Email",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.SellerEmail,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Product Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
                height: 65,
                width: 65,
                imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: widget.ProductImage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SpinKitWave(
                        color: MyAppColors.appColor,
                        size: 30,
                        type: SpinKitWaveType.start),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Name",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.productName,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Price",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.productAmount,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Quantity",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.productQuanity,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Order Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Order Amount",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.totalAmount,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            AppButton(
                onTap: () async {
                  // Create a new PDF document.
                  final PdfDocument document = PdfDocument();
// Add a PDF page and draw text.
                  document.pages.add().graphics.drawString('Hello World!',
                      PdfStandardFont(PdfFontFamily.helvetica, 12),
                      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                      bounds: const Rect.fromLTWH(0, 0, 150, 20));
// Save the document.
                  File('HelloWorld.pdf').writeAsBytes(await document.save());
// Dispose the document.
                  document.dispose();
                },
                text: "Save Contract as PDF"),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
