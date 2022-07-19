// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/UI/Screens/AddSection/shop_view_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';


import '../../../Models/add_shop_model.dart';
import '../../../Services/shop_services.dart';
import '../../../Utils/Colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/res.dart';
import '../../Widgets/appbutton.dart';
import '../../Widgets/auth_textfield_widget.dart';

class EditShopScreen extends StatefulWidget {
  final String shopName;
  final String shopImage;
  final String shopDescription;
  final String shopID;

  EditShopScreen(
      this.shopName, this.shopImage, this.shopDescription, this.shopID);

  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {
  AddShopServices _addShopServices = AddShopServices();
  TextEditingController _shopNameController = TextEditingController();
  TextEditingController _shopDescriptionController = TextEditingController();
  File? _image;

  @override
  void initState() {
    ///We have to populate our text editing controllers with speicifid product details
    _shopNameController = TextEditingController(text: widget.shopName);
    _shopDescriptionController =
        TextEditingController(text: widget.shopDescription);

    super.initState();
  }

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
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: SpinKitWave(color: MyAppColors.appColor),
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              onTap: () {
                makeLoadingTrue();
                _image == null
                    ?
                    // getUrl(context, file: _image).then((imgUrl) {

                    _addShopServices
                        .updateShopWithoutImage(AddShopModel(
                          shopID: widget.shopID,
                          shopName: _shopNameController.text,
                          shopDescription: _shopDescriptionController.text,

                          // contactImage: imgUrl,
                        ))
                        .whenComplete(() => Get.to(ShopViewScreen()))
                    // })
                    : getUrl(context, file: _image).then((imgUrl) {
                        _addShopServices
                            .updateshopwithImage(AddShopModel(
                              shopID: widget.shopID,
                              shopName: _shopNameController.text,
                              shopDescription: _shopDescriptionController.text,
                              shopImage: imgUrl,
                            ))
                            .whenComplete(() => Get.to(ShopViewScreen()));
                      });
              },
              containerheight: 55,
              text: "Update Shop",
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Edit Shop",
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
              child: Row(
                children: [
                  Text("Shop Image",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _image == null
                      ? CachedNetworkImage(
                          height: 150,
                          width: double.infinity,
                          imageBuilder: (context, imageProvider) => Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                          imageUrl: widget.shopImage,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SpinKitWave(
                                  color: MyAppColors.appColor,
                                  type: SpinKitWaveType.start),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error))
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23)
                              //     image: DecorationImage(
                              //         image: Image.file(_image!) as ImageProvider)),
                              ),
                          height: 150,
                          width: double.infinity,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )),
                ),
                Positioned.fill(
                  top: -60,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 19,
                              ),
                              onPressed: () {
                                getImage(true);
                              }),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyAppColors.appColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: authtextfieldWidget(
                  headingtext: "Shop Name",
                  onPwdTap: () {
                    // setState(() {
                    //   isvisible = !isvisible;
                    // });
                  },
                  //    visible: isvisible,
                  isPasswordField: false,
                  suffixIcon2: Icons.visibility_off,
                  suffixIcon: Res.emailicon,
                  maxlength: 20,
                  keyboardtype: TextInputType.text,
                  authcontroller: _shopNameController,
                  showImage: false,
                  showsuffix: false,
                  showpassoricon: true,
                  suffixImage: Res.personicon,
                  text: "Enter Shop Name",
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter more than 6 digit password";
                    } else if (value.length < 6)
                      return "Please Enter atleast 6 password";
                    return null;
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: authtextfieldWidget(
                  headingtext: "Shop Description",
                  onPwdTap: () {
                    // setState(() {
                    //   isvisible = !isvisible;
                    // });
                  },
                  //    visible: isvisible,
                  isPasswordField: false,
                  suffixIcon2: Icons.visibility_off,
                  suffixIcon: Res.emailicon,
                  maxlength: 20,
                  keyboardtype: TextInputType.text,
                  authcontroller: _shopDescriptionController,
                  showImage: false,
                  showsuffix: false,
                  showpassoricon: true,
                  suffixImage: Res.personicon,
                  text: "Enter Shop Description",
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter more than 6 digit password";
                    } else if (value.length < 6)
                      return "Please Enter atleast 6 password";
                    return null;
                  }),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getUrl(BuildContext context, {File? file}) async {
    String postFileUrl = "";
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('backendClass/${file!.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((fileURL) {
          print("I am fileUrl $fileURL");
          postFileUrl = fileURL;
        });
      });
    } catch (e) {
      rethrow;
    }

    return postFileUrl.toString();
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();

    PickedFile? pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
