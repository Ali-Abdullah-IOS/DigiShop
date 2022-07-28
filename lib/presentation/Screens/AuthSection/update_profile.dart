import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Infrastructure/Models/user_model.dart';
import '../../../Infrastructure/Services/user_services.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../../configurations/Utils/res.dart';
import '../../Widgets/appbutton.dart';
import '../../Widgets/auth_textfield_widget.dart';
import 'my_profile.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String userId;
  final String image;
  final String fullName;
  final String phoneNumber;

  UpdateProfileScreen({
    required this.userId,
    required this.image,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  UserServices userServices = UserServices();

  @override
  void initState() {
    ///We have to populate our text editing controllers with speicifid product details
    _fullNameController = TextEditingController(text: widget.fullName);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);

    //contactNumberController = TextEditingController(text: widget.userimage);
    super.initState();
  }

  bool isLoading = false;
  File? _image;

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
      progressIndicator: SpinKitWave(size: 30, color: MyAppColors.appColor),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 4,
                          child: Center(
                              child: SvgPicture.asset(Res.arrowbackgreen)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text("Update Profile",
                        style: GoogleFonts.roboto(
                            // fontFamily: 'Gilroy',
                            color: MyAppColors.blackcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  _image == null
                      ? CachedNetworkImage(
                          height: 110,
                          width: 110,
                          imageBuilder: (context, imageProvider) => Container(
                                width: 110.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                          imageUrl: widget.image.toString(),
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SpinKitWave(
                                  color: MyAppColors.appColor,
                                  size: 30,
                                  type: SpinKitWaveType.start),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error))
                      : Container(
                          decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //         image: Image.file(_image!) as ImageProvider)),
                              borderRadius: BorderRadius.circular(60)),
                          height: 110,
                          width: 110,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )),
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
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: authtextfieldWidget(
                    headingtext: "Full Name",
                    onPwdTap: () {},
                    // visible: isvisible,
                    isPasswordField: false,
                    suffixIcon2: Icons.visibility_off,
                    suffixIcon: Res.personicon,
                    showpassoricon: false,
                    maxlength: 20,
                    keyboardtype: TextInputType.text,
                    authcontroller: _fullNameController,
                    showImage: false,
                    showsuffix: false,
                    suffixImage: Res.personicon,
                    text: "Update FullName",
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please Enter FullName";
                      } else if (value.length < 6)
                        return "Please Enter FullName";
                      return null;
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: authtextfieldWidget(
                    headingtext: "Phone Number",
                    onPwdTap: () {},
                    // visible: isvisible,
                    isPasswordField: false,
                    suffixIcon2: Icons.visibility_off,
                    suffixIcon: Res.phonenumbericon,
                    showpassoricon: false,
                    maxlength: 20,
                    keyboardtype: TextInputType.text,
                    authcontroller: _phoneNumberController,
                    showImage: false,
                    showsuffix: false,
                    suffixImage: Res.personicon,
                    text: "update phone number",
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please Enter PhoneNumber";
                      } else if (value.length < 6)
                        return "Please Enter PhoneNumber";
                      return null;
                    }),
              ),
              SizedBox(
                height: 70,
              ),
              AppButton(
                onTap: () {
                  makeLoadingTrue();
                  _image == null
                      ?
                      // getUrl(context, file: _image).then((imgUrl) {

                      userServices
                          .updateUserDetailsWithoutImage(UserModel(
                            userID: widget.userId,
                            fullName: _fullNameController.text,
                            PhoneNumber: _phoneNumberController.text,

                            // contactImage: imgUrl,
                          ))
                          .whenComplete(() => Get.to(MyProfileScreen()))
                      // })
                      : getUrl(context, file: _image).then((imgUrl) {
                          userServices
                              .updateUserDetailswithImage(UserModel(
                                userID: widget.userId,
                                fullName: _fullNameController.text,
                                PhoneNumber: _phoneNumberController.text,
                                userImage: imgUrl,
                              ))
                              .whenComplete(() => Get.to(MyProfileScreen()));
                        });
                  // Get.to(UpdateProfileScreen(
                  //   image: model.userImage.toString(),
                  //   fullName: model.fullName.toString(),
                  //   phoneNumber: model.PhoneNumber.toString(),
                  // ));
                },
                containerheight: 55,
                text: "Update",
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
