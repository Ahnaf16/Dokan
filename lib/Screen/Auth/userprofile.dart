// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  //

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  //

//show user data
  getUserData() {
    return FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(_currentUser!.email)
        .snapshots();
  }

//update user data
  updateUserInfo() {
    FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(_currentUser!.email)
        .update({
      "name": _nameController!.text,
      "email": _emailController!.text,
      "phone": _phoneController!.text,
      "address": _addressController!.text,
      "dp": _pickedImgStorage,
    }).then(
      (value) => Fluttertoast.showToast(
        msg: 'Update complete',
        backgroundColor: AppColor.appSecColor,
        textColor: AppColor.appMainColor,
      ),
    );
  }

  //update user name
  updateAuthName() {
    return _currentUser!.updateDisplayName(_nameController!.text);
  }

  //image picker, crop
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

      setState(
        () {
          _pickedImg = cropped;
        },
      );
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'Faield to select image');
      print('Error: $e');
    }
  }

//upload to firebase storage
  uploadToStorage() async {
    if (_pickedImg != null) {
      final uploadToStorage = await storageRef
          .child("/UserImg/${_currentUser!.email}")
          .putFile(_pickedImg!);

      final imgLink = await uploadToStorage.ref.getDownloadURL();
      setState(
        () {
          _pickedImgStorage = imgLink;
        },
      );
    }
  }

  noup() {
    storageRef
        .child("/UserImg/${_currentUser!.email}")
        .putFile(_pickedImg!)
        .cancel()
        .then(
          (value) => Fluttertoast.showToast(
            msg: 'No img selected',
          ),
        );
  }

  waitForData() {
    FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(_currentUser!.email)
        .get()
        .then((value) => setState(() {
              noCloudData = false;
            }));
  }

  @override
  void initState() {
    super.initState();
    waitForData();
  }

  final User? _currentUser = FirebaseAuth.instance.currentUser!;
  final Reference storageRef = FirebaseStorage.instance.ref();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;
  bool enableEdit = false;
  bool noCloudData = true;
  File? _pickedImg;
  String? _pickedImgStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder<DocumentSnapshot>(
              stream: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Unexpacted Error',
                    style: AppTextStyle.errorText,
                  );
                }
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    color: AppColor.appMainColor,
                  );
                }
                return Column(
                  children: [
                    cDivider(20),

                    //----------------------------dp-------------------------------------

                    Material(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15),
                      ),
                      color: AppColor.appSecColor,
                      shadowColor: AppColor.appMainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Material(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(50),
                              ),
                              shadowColor: AppColor.appMainColor,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(180),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColor.appMainColor,
                                    borderRadius: BorderRadius.circular(180),
                                  ),
                                  child: noCloudData
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(13),
                                            child: Text(
                                              'no data',
                                              style: AppTextStyle.errorText
                                                  .copyWith(
                                                color: AppColor.appSecColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          child: snapshot.data!["dp"] == null
                                              ? FittedBox(
                                                  child: Text(
                                                    snapshot.data!["name"][0]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.appSecColor,
                                                    ),
                                                    //'no img',
                                                  ),
                                                )
                                              : Material(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color:
                                                          AppColor.appMainColor,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(50),
                                                  ),
                                                  borderOnForeground: true,
                                                  child: _pickedImg != null
                                                      ? Image.file(
                                                          _pickedImg!,
                                                        )
                                                      : Image.network(
                                                          snapshot.data!["dp"],
                                                        ),
                                                ),
                                        ),
                                ),
                              ),
                            ),
                            //--------------

                            Visibility(
                              visible: enableEdit,
                              child: Material(
                                elevation: 10,
                                color: AppColor.appSecColor,
                                shadowColor: AppColor.appMainColor,
                                type: MaterialType.button,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(30),
                                ),
                                child: IconButton(
                                  splashRadius: 23,
                                  splashColor: AppColor.appSecColor,
                                  onPressed: () {
                                    pickImageSource(context);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColor.appMainColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    cDivider(30),

                    //----------------------------details-------------------------------------

                    Material(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15),
                      ),
                      color: AppColor.appSecColor,
                      shadowColor: AppColor.appMainColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          children: [
                            //----------------------------name-------------------------------------

                            TextFormField(
                              enabled: enableEdit,
                              controller: _nameController =
                                  TextEditingController(
                                      text: snapshot.data!["name"]),
                              style: AppTextStyle.smallTextStyle,
                              decoration: textfilesStyle('Name').copyWith(
                                filled: false,
                              ),
                            ),
                            cDivider(10),

                            //----------------------------email-------------------------------------

                            TextFormField(
                              enabled: false,
                              controller: _emailController =
                                  TextEditingController(
                                      text: snapshot.data!["email"]),
                              style: AppTextStyle.smallTextStyle,
                              decoration: textfilesStyle('Email').copyWith(
                                filled: false,
                              ),
                            ),
                            cDivider(10),

                            //----------------------------phone-------------------------------------

                            TextFormField(
                              enabled: enableEdit,
                              controller: _phoneController =
                                  TextEditingController(
                                      text: snapshot.data!["phone"]),
                              style: AppTextStyle.smallTextStyle,
                              decoration: textfilesStyle('Phone').copyWith(
                                filled: false,
                              ),
                            ),
                            cDivider(10),

                            //----------------------------address-------------------------------------

                            TextFormField(
                              enabled: enableEdit,
                              controller: _addressController =
                                  TextEditingController(
                                      text: snapshot.data!["address"]),
                              style: AppTextStyle.smallTextStyle,
                              decoration: textfilesStyle('Address').copyWith(
                                filled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    cDivider(15),
                    //----------------------------edit-------------------------------------

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: enableEdit,
                            child: editUpdateButton(
                              'Update',
                              15,
                              Icons.upgrade,
                              () async {
                                enableEdit = !enableEdit;
                                _pickedImg != null
                                    ? await uploadToStorage()
                                    : noup();
                                await updateAuthName();
                                await updateUserInfo();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          editUpdateButton(
                            (enableEdit == false) ? 'Edit' : 'Cancel',
                            15,
                            (enableEdit == false) ? Icons.edit : Icons.close,
                            () {
                              setState(() {
                                enableEdit = !enableEdit;
                                _pickedImg = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    cDivider(50),
                    // SizedBox(
                    //   height: 300,
                    //   width: 300,
                    //   child: snapshot.data!.exists
                    //       ? Image.network(
                    //           snapshot.data!["dp"],
                    //         )
                    //       : Text(
                    //           'no data',
                    //         ),
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> pickImageSource(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColor.appSecColor,
      elevation: 10,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(15),
          topStart: Radius.circular(15),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Camera',
                style: AppTextStyle.smallTextStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                selectImg(ImageSource.camera);
              },
              leading: Icon(
                Icons.camera,
                color: AppColor.appMainColor,
              ),
            ),
            ListTile(
              title: Text(
                'Gallery',
                style: AppTextStyle.smallTextStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                selectImg(ImageSource.gallery);
              },
              leading: Icon(
                Icons.image,
                color: AppColor.appMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material editUpdateButton(
    String label,
    double radius,
    IconData icon,
    VoidCallback onButtontap,
  ) {
    return Material(
      elevation: 10,
      type: MaterialType.button,
      color: AppColor.appSecColor,
      shadowColor: AppColor.appMainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(radius),
      ),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          primary: AppColor.appMainColor,
        ),
        onPressed: onButtontap,
        icon: Icon(
          icon,
          color: AppColor.appMainColor,
        ),
        label: Text(
          label,
          style: AppTextStyle.smallTextStyle,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.appBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: AppColor.appMainColor,
        ),
      ),
      title: Text(
        'Dokan',
        style: AppTextStyle.bodyTextStyle,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => SearchPage(),
            ),
          ),
          icon: Icon(
            Icons.search,
            color: AppColor.appMainColor,
          ),
        )
      ],
    );
  }
}
