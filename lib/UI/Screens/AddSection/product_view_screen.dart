// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Models/product_Model.dart';
import '../../../Services/product_services.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/res.dart';
import '../../../Utils/res.dart';
import '../../Widgets/product_card_widget.dart';
import '../../Widgets/product_delete_confirm.dart';
import 'add_categories.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductViewScreen extends StatefulWidget {
  final String CatgoryID;
  final String ShopID;

  ProductViewScreen(this.CatgoryID, this.ShopID);

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  ProductServices _productServices = ProductServices();
  TextEditingController _searchController = TextEditingController();
  List<ProductModel> searchedContact = [];

  List<ProductModel> contactList = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<ProductModel> contactListDB = [];

  void _searchedContacts(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.productName.toString().toLowerCase() +
          " " +
          i.productName.toString().toLowerCase() +
          i.productName.toString();

      var defaultCase = i.productName.toString() +
          " " +
          i.productName.toString() +
          i.productName.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedContact.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyAppColors.appColor,
        onPressed: () {
          Get.to(AddProduct(widget.CatgoryID, widget.ShopID));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
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
                    width: 20,
                  ),
                  Text("Products For Rent",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: MyAppColors.blackcolor.withOpacity(0.1)),
                child: TextFormField(
                  onChanged: (val) {
                    _searchedContacts(val);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Products With Name",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            StreamProvider.value(
                value: _productServices.streamProducts(widget.CatgoryID),
                initialData: [ProductModel()],
                builder: (context, child) {
                  contactListDB = context.watch<List<ProductModel>>();
                  List<ProductModel> list = context.watch<List<ProductModel>>();
                  return list.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("Add Products",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                      : list[0].productId == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: SpinKitWave(
                                    color: Colors.blue,
                                    type: SpinKitWaveType.start),
                              ),
                            )
                          : list.isEmpty
                              ? Center(child: Text("No Data"))
                              : searchedContact.isEmpty
                                  ? isSearched == true
                                      ? Center(child: Text("NO Data"))
                                      : Container(
                                          // height: 550,
                                          // width: MediaQuery.of(context).size.width,

                                          child: ListView.builder(
                                              itemCount: list.length,
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (context, i) {
                                                return ProductCardWidget(
                                                  list[i].productId.toString(),
                                                  list[i].categoryId.toString(),
                                                  list[i]
                                                      .productName
                                                      .toString(),
                                                  list[i]
                                                      .productPrice
                                                      .toString(),
                                                  list[i]
                                                      .productDesc
                                                      .toString(),
                                                  list[i]
                                                      .productquantity
                                                      .toString(),
                                                  list[i]
                                                      .productImage
                                                      .toString(),
                                                );
                                              }))
                                  : Container(
                                      // height: 550,
                                      // width: MediaQuery.of(context).size.width,

                                      child: ListView.builder(
                                          itemCount: searchedContact.length,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            return ProductCardWidget(
                                              searchedContact[i]
                                                  .productId
                                                  .toString(),
                                              searchedContact[i]
                                                  .categoryId
                                                  .toString(),
                                              searchedContact[i]
                                                  .productName
                                                  .toString(),
                                              searchedContact[i]
                                                  .productPrice
                                                  .toString(),
                                              searchedContact[i]
                                                  .productDesc
                                                  .toString(),
                                              searchedContact[i]
                                                  .productquantity
                                                  .toString(),
                                              searchedContact[i]
                                                  .productImage
                                                  .toString(),
                                            );
                                          }));
                })
          ],
        ),
      ),
    );
  }
}
