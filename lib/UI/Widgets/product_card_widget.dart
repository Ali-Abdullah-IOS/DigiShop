import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/UI/Widgets/product_delete_confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../Utils/Colors.dart';
import '../../Utils/res.dart';
import '../Screens/AddSection/edit_product_screen.dart';

class ProductCardWidget extends StatefulWidget {
  final String productID;
  final String categoryID;
  final String productName;
  final String productPrice;
  final String productDescription;
  final String productQuantity;
  final String productImage;

  ProductCardWidget(
      this.productID,
      this.categoryID,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.productQuantity,
      this.productImage);

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        height: 130,
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                            height: 50,
                            width: 60,
                            imageBuilder: (context, imageProvider) => Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                            imageUrl: widget.productImage.toString(),
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SpinKitWave(
                                    color: MyAppColors.appColor,
                                    type: SpinKitWaveType.start),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error)),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.productName.toString(),
                                style: GoogleFonts.roboto(
                                    // fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20)),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.to(EditProductScreen(
                                  widget.productID,
                                  widget.categoryID,
                                  widget.productName,
                                  widget.productPrice,
                                  widget.productDescription,
                                  widget.productQuantity,
                                  widget.productImage));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: MyAppColors.appColor,
                            )),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ProductDeleteConfirmDialog(
                                        widget.productID);
                                  });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: MyAppColors.redcolor,
                            ))
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: GoogleFonts.roboto(
                            //fontFamily: 'Gilroy',
                            color: MyAppColors.blackcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        text: widget.productDescription.toString()),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("\$ " + widget.productPrice,
                          style: GoogleFonts.roboto(
                              // fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
