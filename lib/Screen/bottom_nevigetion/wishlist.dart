// ignore_for_file: prefer_const_literals_to_create_immutables ,prefer_const_constructors

import 'dart:io';
import 'package:dokan/Properties/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  //

  Future selectImg(ImageSource imgSource) async {
    try {
      final pickImg = await ImagePicker().pickImage(source: imgSource);

      if (pickImg == null) {
        return Fluttertoast.showToast(
          msg: 'No image selected',
        );
      }

      final cropped = await ImageCropper.cropImage(
        sourcePath: pickImg.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 700,
        maxWidth: 700,
        androidUiSettings: AndroidUiSettings(
          backgroundColor: AppColor.appSecColor,
          toolbarColor: AppColor.appSecColor,
          toolbarWidgetColor: AppColor.appMainColor,
          activeControlsWidgetColor: AppColor.appSecColor,
          dimmedLayerColor: AppColor.appSecColor.withOpacity(.5),
          cropFrameColor: AppColor.appMainColor,
          cropGridColor: AppColor.appMainColor,
          toolbarTitle: 'Crop Image',
          cropGridStrokeWidth: 2,
        ),
      );

      if (cropped != null) {
        final snapshot =
            await fStorage.ref().child("/UserImg/$cUserMail").putFile(cropped);

        final imgLink = await snapshot.ref.getDownloadURL();
        setState(
          () {
            _imgFromFstoreg = imgLink;
          },
        );
      } else {
        Fluttertoast.showToast(msg: 'Error showing image');
      }
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'Faield to select image');
      print('Error: $e');
    }
  }

  final fStorage = FirebaseStorage.instance;
  final cUserMail = FirebaseAuth.instance.currentUser!.email;
  String? _imgFromFstoreg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Text(
                  "",
                  style: AppTextStyle.bodyTextStyle,
                ),
                Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColor.appMainColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadiusDirectional.circular(15),
                  ),
                  borderOnForeground: true,
                  child: _imgFromFstoreg == null
                      ? Text('No image')
                      : Image.network(
                          _imgFromFstoreg!,
                          // fit: BoxFit.fitWidth,
                        ),
                ),
                IconButton(
                  splashRadius: 23,
                  splashColor: AppColor.appSecColor,
                  onPressed: () {
                    selectImg(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColor.appMainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
