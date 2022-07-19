// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:io';

import 'package:digirental_shop_app/UI/Screens/AddSection/shop_view_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';


import '../../../Helpers/helper.dart';
import '../../../Models/add_shop_model.dart';
import '../../../Services/shop_services.dart';
import '../../../Utils/Colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/res.dart';
import '../../Widgets/appbutton.dart';
import '../../Widgets/auth_textfield_widget.dart';

class AddShopScreen extends StatefulWidget {
  const AddShopScreen({Key? key}) : super(key: key);

  @override
  State<AddShopScreen> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  AddShopServices _shopServices = AddShopServices();
  TextEditingController _shopName = TextEditingController();
  TextEditingController _shopDescription = TextEditingController();
  File? _image;
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
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: SpinKitWave(color: MyAppColors.appColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add Shop",
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
                      child: Container(
                          height: 150,
                          width: double.infinity,
                          // child: SvgPicture.asset(
                          //   Res.invitefriendbanner,
                          //   fit: BoxFit.cover,
                          // ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                                width: 3, color: MyAppColors.appColor),
                            //shape: BoxShape.circle,

                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _image == null
                                  ? AssetImage(Res.bannerhomepage)
                                  : FileImage(_image!) as ImageProvider,
                            ),
                          ))),
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
                    authcontroller: _shopName,
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
                    authcontroller: _shopDescription,
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
                height: 200,
              ),
              AppButton(
                onTap: () async {
                  makeLoadingTrue();
                  getUrl(context, file: _image).then((imgUrl) {
                    _shopServices.createShop(AddShopModel(
                      shopName: _shopName.text,
                      shopDescription: _shopDescription.text,
                      shopImage: imgUrl,
                      userID: getUserID(),
                      //  shopID: getUserID()
                    ));
                    makeLoadingFalse();
                  }).whenComplete(() => Get.to(ShopViewScreen()));
                },
                containerheight: 55,
                text: "Add Shop",
              ),
            ],
          ),
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
