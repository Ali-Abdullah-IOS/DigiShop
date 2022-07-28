// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Infrastructure/Models/add_shop_model.dart';
import '../../../Infrastructure/Services/shop_services.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../Widgets/auth_textfield_widget.dart';
import '../../Widgets/product_delete_confirm.dart';
import '../../Widgets/shop_delete_confirm.dart';
import '../../Widgets/shops_card_widget.dart';
import 'add_categories.dart';
import 'add_product_screen.dart';
import 'add_shop_screen.dart';
import 'catgories_view_screen.dart';
import 'edit_product_screen.dart';
import 'edit_shop_screen.dart';

class ShopViewScreen extends StatefulWidget {
  const ShopViewScreen(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  State<ShopViewScreen> createState() => _ShopViewScreenState();
}

class _ShopViewScreenState extends State<ShopViewScreen> {
  AddShopServices _shopServices = AddShopServices();
  TextEditingController _searchController = TextEditingController();
  List<AddShopModel> searchedContact = [];

  List<AddShopModel> contactList = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<AddShopModel> contactListDB = [];

  void _searchedContacts(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.shopName.toString().toLowerCase() +
          " " +
          i.shopName.toString().toLowerCase() +
          i.shopName.toString();

      var defaultCase = i.shopName.toString() +
          " " +
          i.shopName.toString() +
          i.shopName.toString();

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
        backgroundColor: MyAppColors.redcolor,
        onPressed: () {
          Get.to(AddShopScreen());
        },
        child: Text('-'),
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
                  Text("Rental Shops",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                ],
              ),
            ),
            SizedBox(
              height: 14,
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
                      hintText: "Search Shops With Name",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            StreamProvider.value(
                value: _shopServices.streamShops(),
                initialData: [AddShopModel()],
                builder: (context, child) {
                  contactListDB = context.watch<List<AddShopModel>>();
                  List<AddShopModel> list = context.watch<List<AddShopModel>>();
                  return list.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("Add Shops",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                      : list[0].shopID == null
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
                                                return ShopsCardWidget(
                                                  list[i].shopName.toString(),
                                                  list[i].shopImage.toString(),
                                                  list[i]
                                                      .shopDescription
                                                      .toString(),
                                                  list[i].shopID.toString(),
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
                                            return ShopsCardWidget(
                                              searchedContact[i]
                                                  .shopName
                                                  .toString(),
                                              searchedContact[i]
                                                  .shopImage
                                                  .toString(),
                                              searchedContact[i]
                                                  .shopDescription
                                                  .toString(),
                                              searchedContact[i]
                                                  .shopID
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
