// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:image_picker/image_picker.dart';

import '../../../Infrastructure/Models/product_Model.dart';
import '../../../Infrastructure/Services/product_services.dart';
import '../../../configurations/Utils/Colors.dart';
import '../../../configurations/Utils/res.dart';
import '../../Widgets/appbutton.dart';
import '../../Widgets/auth_textfield_widget.dart';

class EditProductScreen extends StatefulWidget {
  final String productID;
  final String categoryID;
  final String productName;
  final String productPrice;
  final String productDescription;
  final String productQuantity;
  final String productImage;

  EditProductScreen(
      this.productID,
      this.categoryID,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.productQuantity,
      this.productImage);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  ProductServices _productServices = ProductServices();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDescController = TextEditingController();
  TextEditingController _productQuanitityController = TextEditingController();

  File? _image;

  @override
  void initState() {
    ///We have to populate our text editing controllers with speicifid product details
    _productNameController = TextEditingController(text: widget.productName);
    _productPriceController = TextEditingController(text: widget.productPrice);
    _productDescController =
        TextEditingController(text: widget.productDescription);
    _productQuanitityController =
        TextEditingController(text: widget.productQuantity);

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

                    _productServices
                        .updateProductWithoutImage(ProductModel(
                          categoryId: widget.categoryID,
                          productId: widget.productID,
                          productName: _productNameController.text,
                          productPrice: num.parse(_productPriceController.text),
                          productquantity: _productQuanitityController.text,
                          productDesc: _productDescController.text,

                          // contactImage: imgUrl,
                        ))
                        .whenComplete(() => Get.back())
                    // })
                    : getUrl(context, file: _image).then((imgUrl) {
                        _productServices
                            .updateProductwithImage(ProductModel(
                                categoryId: widget.categoryID,
                                productId: widget.productID,
                                productName: _productNameController.text,
                                productPrice:
                                    num.parse(_productPriceController.text),
                                productquantity:
                                    _productQuanitityController.text,
                                productDesc: _productDescController.text,
                                productImage: imgUrl))
                            .whenComplete(() => Get.back());
                      });
              },
              containerheight: 55,
              text: "Update Product",
            ),
            SizedBox(
              height: 30,
            )
          ],
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Edit Product",
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
                    Text("Product Image",
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
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                            imageUrl: widget.productImage,
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
                    headingtext: "Product Name",
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
                    authcontroller: _productNameController,
                    showImage: false,
                    showsuffix: false,
                    showpassoricon: true,
                    suffixImage: Res.personicon,
                    text: "Enter Product Name",
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
                    headingtext: "Product Price",
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
                    authcontroller: _productPriceController,
                    showImage: false,
                    showsuffix: false,
                    showpassoricon: true,
                    suffixImage: Res.personicon,
                    text: "Enter Product Price",
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
                    headingtext: "Product Quantity",
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
                    authcontroller: _productQuanitityController,
                    showImage: false,
                    showsuffix: false,
                    showpassoricon: true,
                    suffixImage: Res.personicon,
                    text: "Enter Product Quantity",
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
                    headingtext: "Product Description",
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
                    authcontroller: _productDescController,
                    showImage: false,
                    showsuffix: false,
                    showpassoricon: true,
                    suffixImage: Res.personicon,
                    text: "Enter Product Description",
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
