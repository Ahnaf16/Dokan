// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/herotest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  //
  final String userName;

  const UserDetails({Key? key, required this.userName}) : super(key: key);

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

  cancelUplode() {
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

  final User? _currentUser = FirebaseAuth.instance.currentUser!;
  final Reference storageRef = FirebaseStorage.instance.ref();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;
  bool enableEdit = false;
  bool isloading = false;
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
            //
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
                  return Text(
                    'Error loading data',
                    style: AppTextStyle.errorText,
                  );
                }

                //----------------------------conection waiting-------------------------------------

                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Column(
                //     children: [
                //       loadingHeader(context),
                //       cDivider(30),
                //       loadingBody(context),
                //       cDivider(30),
                //     ],
                //   );
                // }
                return Column(
                  children: [
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
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColor.appMainColor,
                                  width: 2,
                                ),
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
                                  child: SizedBox(
                                    child: _pickedImg != null
                                        ? CircleAvatar(
                                            child: Image.file(
                                            _pickedImg!,
                                          ))
                                        : Container(
                                            child: snapshot.data!["dp"] != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              Herotest(
                                                            theIMG: snapshot
                                                                .data!["dp"],
                                                            tag: snapshot
                                                                .data!["email"],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Hero(
                                                      tag: snapshot
                                                          .data!["email"],
                                                      child: CircleAvatar(
                                                        child:
                                                            _pickedImg != null
                                                                ? Image.file(
                                                                    _pickedImg!,
                                                                  )
                                                                : Image.network(
                                                                    snapshot.data![
                                                                        "dp"],
                                                                  ),
                                                      ),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        AppColor.appMainColor,
                                                    child: Text(
                                                      snapshot.data!["name"][0]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: AppTextStyle
                                                          .headerStyle
                                                          .copyWith(
                                                        color: AppColor
                                                            .appSecColor,
                                                      ),
                                                    ),
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
                                await uploadToStorage();
                                await updateAuthName();
                                await updateUserInfo();
                                setState(() {
                                  enableEdit = !enableEdit;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          editUpdateButton(
                            enableEdit == false ? 'Edit' : 'Cancel',
                            15,
                            enableEdit == false ? Icons.edit : Icons.close,
                            () {
                              (enableEdit == true && _pickedImg != null)
                                  ? cancelUplode()
                                  : null;
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SizedBox loadingBody(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Material(
        elevation: 0,
        color: Colors.grey[300],
        shadowColor: AppColor.appMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cDivider(20),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cDivider(20),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cDivider(20),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox loadingHeader(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Material(
        elevation: 0,
        color: Colors.grey[300],
        shadowColor: AppColor.appMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
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

  Widget editUpdateButton(
    String label,
    double radius,
    IconData icon,
    VoidCallback onButtontap,
  ) {
    return OutlinedButton(
      style: TextButton.styleFrom(
        primary: AppColor.appMainColor,
        backgroundColor: AppColor.appSecColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onButtontap,
      child: isloading
          ? CircularProgressIndicator(
              color: AppColor.appMainColor,
            )
          : Row(
              children: [
                Icon(
                  icon,
                  color: AppColor.appMainColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  label,
                  style: AppTextStyle.smallTextStyle,
                ),
              ],
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
