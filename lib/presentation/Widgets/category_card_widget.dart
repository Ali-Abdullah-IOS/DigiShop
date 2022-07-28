import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../configurations/Utils/Colors.dart';
import '../Screens/AddSection/catgories_view_screen.dart';
import '../Screens/AddSection/edit_categories_Screen.dart';
import '../Screens/AddSection/edit_shop_screen.dart';
import '../Screens/AddSection/product_view_screen.dart';
import 'category_delete_confirm.dart';

class CategoryCardWidget extends StatefulWidget {
  final String categoryName;
  final String cagoryImage;
  final String categoryID;
  final String shopID;

  // final String shopID;

  CategoryCardWidget(
      this.categoryName, this.cagoryImage, this.categoryID, this.shopID

      // this.shopID
      );

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: () {
          Get.to(ProductViewScreen(widget.categoryID,widget.shopID));
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
                              imageUrl: widget.cagoryImage,
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
                              Text(widget.categoryName,
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
                                Get.to(EditCategories(
                                    widget.categoryName,
                                    widget.cagoryImage,
                                    widget.categoryID,
                                    widget.shopID));
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
                                      return CategoryDeleteConfirmWidget(
                                          widget.categoryID
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
