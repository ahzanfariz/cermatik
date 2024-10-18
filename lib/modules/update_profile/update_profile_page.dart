import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/constant.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';
import '../../utils/app_utils.dart';
import '../../widgets/choose_avatar_bottom_sheet.dart';

class UpdateProfilePage extends StatefulWidget {
  MainModel model;

  UpdateProfilePage(this.model);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final organizationController = TextEditingController();
  final aboutController = TextEditingController();

  final GlobalKey<FormState> updateProfileFormKey =
      GlobalKey<FormState>(debugLabel: '__updateProfileFormKey__');

  Timer? _timer;

  final ImagePicker _picker = ImagePicker();

  late XFile _imageFile;
  dynamic _pickImageError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fullNameController.text = widget.model.user.name!;
    phoneController.text = widget.model.user.phone!;
    emailController.text = widget.model.user.email!;
    organizationController.text = widget.model.user.organization ?? "";
    aboutController.text = widget.model.user.about ?? "";
  }

  Future _validateAndSubmit(MainModel model) async {
    if (!updateProfileFormKey.currentState!.validate()) {
      return;
    }

    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    updateProfileFormKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      var data = {
        'name': fullNameController.text,
        'email': emailController.text,
        // 'password': pas.text,
        'phone': phoneController.text,
        'organization': organizationController.text,
        'about': aboutController.text,
      };

      var responseData = await model.editProfile(data);
      if (responseData["data"]['name'] != null) {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        Navigator.of(context).pop();
        //
        AppUtils.showSnackBar(model.message,
            title: "Success", status: MessageStatus.SUCCESS);
      } else {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        AppUtils.showSnackBar(model.message, status: MessageStatus.ERROR);
      }
    } catch (e) {
      print(e);
      print("Unathorized");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  // Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: ThemeColor.black,
                )),
            title: Text(
              "Update Profile",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.black),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: ThemeColor.lighterPrimary,
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: updateProfileFormKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child:
                                // showModalBottomSheet(
                                //     context: context,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.vertical(
                                //         top: Radius.circular(16),
                                //       ),
                                //     ),
                                //     clipBehavior: Clip.antiAliasWithSaveLayer,
                                //     backgroundColor: Colors.white,
                                //     builder: (context) {
                                //       return ChooseAvatarBottomSheet(
                                //           allAvatars: updateProfileController
                                //               .allAvatars,
                                //           onTap: (profilePic) {
                                //             updateProfileController
                                //                 .profilePicUrl
                                //                 .value = profilePic;
                                //           });
                                //     });

                                Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: ThemeColor.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: ThemeColor.white,
                                      //     AppUtils.getRandomAvatarBgColor(),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                            imageUrl: model.user.image == null
                                                ? ""
                                                : "${Constant.baseUrl}${Constant.publicAssets}${model.user.image}",
                                            // "${updateProfileController.profilePicUrl.value}",
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                                  child: Container(
                                                    // color: ThemeColor.white,
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: ThemeColor.primary,
                                                    ),
                                                  ),
                                                ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Container(
                                                    color: ThemeColor.white,
                                                    alignment: Alignment.center,
                                                    // margin: EdgeInsets.all(8),
                                                    child: Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color:
                                                          ThemeColor.grey_300,
                                                      size: 80,
                                                    ))),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: -4,
                                        child: InkWell(
                                            onTap: () {
                                              _showPicker(context, model);
                                            },
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ThemeColor.primary,
                                              ),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: ThemeColor.white,
                                                size: 16,
                                              ),
                                            ))),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Full Name",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: fullNameController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                color: ThemeColor.black, fontSize: 14),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                size: 18,
                              ),
                              contentPadding: EdgeInsets.all(12),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "Full Name",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: ThemeColor.grey_500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: ThemeColor.white,
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Full Name can't be emtpy.";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: ThemeColor.black, fontSize: 14),
                            decoration: InputDecoration(
                              enabled: false,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                size: 18,
                              ),
                              contentPadding: EdgeInsets.all(12),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: ThemeColor.grey_500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeColor.grey_300),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: ThemeColor.grey_100,
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Email can't be emtpy.";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Phone",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // TextFormField(
                          //   controller: phoneController,
                          //   keyboardType: TextInputType.phone,
                          //   style: TextStyle(
                          //       color: ThemeColor.black, fontSize: 14),
                          //   decoration: InputDecoration(
                          //     prefixText:
                          //         // padding: EdgeInsets.only(
                          //         //     top: 17, bottom: 17, left: 10),
                          //         "420",
                          //     prefixStyle: TextStyle(
                          //         color: ThemeColor.textPrimary,
                          //         fontWeight: FontWeight.bold),
                          //     //  Icon(
                          //     //   Icons.phone_outlined,
                          //     //   size: 18,
                          //     // ),
                          //     contentPadding: EdgeInsets.all(12),
                          //     floatingLabelBehavior:
                          //         FloatingLabelBehavior.never,
                          //     hintText: "Number Phone",
                          //     hintStyle: TextStyle(
                          //         fontSize: 14, color: ThemeColor.grey_500),
                          //     border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10)),
                          //     enabledBorder: OutlineInputBorder(
                          //         borderSide:
                          //             BorderSide(color: Colors.transparent),
                          //         borderRadius: BorderRadius.circular(10)),
                          //     filled: true,
                          //     fillColor: ThemeColor.white,
                          //   ),
                          //   validator: (v) {
                          //     if (v!.isEmpty) {
                          //       return "Phone Number can't be emtpy.";
                          //     }
                          //     return null;
                          //   },
                          //   textInputAction: TextInputAction.next,
                          //   autovalidateMode:
                          //       AutovalidateMode.onUserInteraction,
                          // ),
                          IntlPhoneField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "Number Phone",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: ThemeColor.grey_500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: ThemeColor.white,
                            ),
                            disableLengthCheck: false,
                            style: TextStyle(
                                color: ThemeColor.black, fontSize: 14),
                            initialCountryCode: 'CZ',
                            showDropdownIcon: false,
                            flagsButtonPadding:
                                EdgeInsets.only(left: 12, top: 1.2),
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (v) {
                              if (v.toString().isEmpty) {
                                return "Phone Number can't be emtpy.";
                              }
                              return null;
                            },
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Organization",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: organizationController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: ThemeColor.black, fontSize: 14),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.group_outlined,
                                size: 18,
                              ),
                              contentPadding: EdgeInsets.all(12),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "Organization",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: ThemeColor.grey_500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: ThemeColor.white,
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Organization can't be emtpy.";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "About",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: aboutController,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                                color: ThemeColor.black, fontSize: 14),
                            maxLines: 8,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "Wriye few lines about yourself",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: ThemeColor.grey_500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: ThemeColor.white,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 44,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _validateAndSubmit(model);
                                },
                                child: Text("Update",
                                    style: TextStyle(color: ThemeColor.white)),
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: ThemeColor.primary,
                                ),
                              )),
                        ]),
                  ))));
    });
  }

  void _showPicker(context, MainModel model) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Text(
                        'Change Profile Photo',
                      )),
                  SizedBox(height: 10),
                  ListTile(
                      leading: SvgPicture.asset(
                        'assets/icon/gallery.svg',
                        height: 40,
                      ),
                      title: new Text('Choose from gallery'),
                      onTap: () async {
                        // _imgFromGallery();
                        Navigator.of(context).pop();
                        await onImageButtonPressed(model, ImageSource.gallery);
                      }),
                  SizedBox(height: 10),
                  // new ListTile(
                  //   // leading: SvgPicture.asset("assets/icons/camera.svg",
                  //   //     height: 60,
                  //   //     color: Pallete.subPrimary,
                  //   //     semanticsLabel: 'A red up arrow'),
                  //   title: new Text('Buka Kamera',
                  //       style: TextStyle(
                  //           // color: Pallete.primary,
                  //           fontFamily: 'Nunito',
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 26)),
                  //   onTap: () async {
                  //     // _imgFromCamera();
                  //     Navigator.of(context).pop();
                  //     // await onImageButtonPressed(model, ImageSource.camera);
                  //   },
                  // ),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  Future<void> onImageButtonPressed(MainModel model, ImageSource source) async {
    // if (_controller != null) {
    //   await _controller.setVolume(0.0);
    // }
    // if (isVideo) {
    //   final PickedFile file = await _picker.getVideo(
    //       source: source, maxDuration: const Duration(seconds: 10));
    //   await _playVideo(file);
    // } else {
    // await _displayPickImageDialog(context,
    //     (double maxWidth, double maxHeight, int quality) async {

    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        // maxWidth: 100,
        // maxHeight: 100,
        imageQuality: 100,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
      //
      late FormData formData;
      late dynamic response;
      //
      if (pickedFile != null) {
        _timer?.cancel();
        await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

        formData = FormData.fromMap({
          'name': model.user.name,
          'email': model.user.email,
          'image': await MultipartFile.fromFile(_imageFile.path,
              filename: _imageFile.path.split('/').last)
        });

        response = await model.editProfile(formData);

        if (response['data'] != null) {
          _timer?.cancel();
          await EasyLoading.dismiss();
        }
      }
    } catch (e) {
      _timer?.cancel();
      await EasyLoading.dismiss();
      setState(() {
        _pickImageError = e;
      });
    }
    // });
  }
}
