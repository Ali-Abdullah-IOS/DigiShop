import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/presentation/Widgets/shop_delete_confirm.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configurations/Utils/Colors.dart';
import '../Screens/AddSection/catgories_view_screen.dart';
import '../Screens/AddSection/edit_shop_screen.dart';

class ShopsCardWidget extends StatefulWidget {
  final String shopName;
  final String shopImage;
  final String shopDescription;
  final String shopID;

  ShopsCardWidget(
      this.shopName, this.shopImage, this.shopDescription, this.shopID);

  @override
  State<ShopsCardWidget> createState() => _ShopsCardWidgetState();
}

class _ShopsCardWidgetState extends State<ShopsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: () {
          Get.to(CategoryView(widget.shopID));
        },
        child: Container(
          height: 120,
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                              imageUrl: widget.shopImage,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      SpinKitWave(
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
                              Text(widget.shopName,
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
                                Get.to(EditShopScreen(widget.shopName, widget.shopImage,
                                    widget.shopDescription, widget.shopID));
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
                                      return ShopDeleteConfirmDialog(widget.shopID
                                          //widget.contactId

                                          );
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
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: GoogleFonts.roboto(
                            //fontFamily: 'Gilroy',
                            color: MyAppColors.blackcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        text: widget.shopDescription),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
