// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



import '../../../Infrastructure/Models/categoriesModel.dart';
import '../../../Infrastructure/Services/category_services.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../Widgets/category_card_widget.dart';
import 'add_categories.dart';
import 'edit_categories_Screen.dart';

class CategoryView extends StatefulWidget {
  final String shopID;

  CategoryView(this.shopID);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  TextEditingController _searchController = TextEditingController();
  List<CategoriesModel> searchedContact = [];

  List<CategoriesModel> contactList = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<CategoriesModel> contactListDB = [];

  void _searchedContacts(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.categoryName.toString().toLowerCase() +
          " " +
          i.categoryName.toString().toLowerCase() +
          i.categoryName.toString();

      var defaultCase = i.categoryName.toString() +
          " " +
          i.categoryName.toString() +
          i.categoryName.toString();

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

  CategoryServices _categoryServices = CategoryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyAppColors.appColor,
        onPressed: () {
          Get.to(AddCategories(widget.shopID));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
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
                    width: 15,
                  ),
                  Text("Categories",
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
                      hintText: "Search Categories With Name",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            StreamProvider.value(
                value: _categoryServices.streamCategories(widget.shopID),
                initialData: [CategoriesModel()],
                builder: (context, child) {
                  contactListDB = context.watch<List<CategoriesModel>>();
                  List<CategoriesModel> list =
                      context.watch<List<CategoriesModel>>();
                  return list.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("Add Catgeories",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                      : list[0].categoryId == null
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
                                                return CategoryCardWidget(

                                                    list[i]
                                                        .categoryName
                                                        .toString(),
                                                    list[i]
                                                        .categoryImage
                                                        .toString(),
                                                    list[i]
                                                        .categoryId
                                                        .toString(),
                                                    list[i].shopId.toString()

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
                                            return CategoryCardWidget(
                                              searchedContact[i]
                                                  .categoryName
                                                  .toString(),
                                              searchedContact[i]
                                                  .categoryImage
                                                  .toString(),
                                              searchedContact[i]
                                                  .categoryId
                                                  .toString(),
                                              searchedContact[i]
                                                  .shopId
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
