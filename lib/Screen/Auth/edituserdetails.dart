// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditUserDetails extends StatelessWidget {
//

  User? _curentUser = FirebaseAuth.instance.currentUser;

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;

  updateData() {
    return FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(_curentUser!.email)
        .snapshots();
  }

  updateUserInfo() {
    FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(_curentUser!.email)
        .update({
      "name": _nameController!.text,
      "email": _emailController!.text,
      "phone": _phoneController!.text,
      "address": _addressController!.text,
    }).then(
      (value) => Fluttertoast.showToast(
        msg: 'Update Complite',
        backgroundColor: AppColor.appSecColor,
        textColor: AppColor.appMainColor,
      ),
    );
  }

  updateAuthName() {
    return _curentUser!.updateDisplayName(_nameController!.text);
  }

  // updateAuthEmail() {
  //   return _curentUser!.updateEmail(_emailController!.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder<DocumentSnapshot>(
                stream: updateData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      color: AppColor.appMainColor,
                    );
                  }
                  var data = snapshot.data;
                  return Column(
                    children: [
                      cDivider(20),
                      imgPicker(context, data),
                      cDivider(30),
                      TextFormField(
                        controller: _nameController =
                            TextEditingController(text: snapshot.data!["name"]),
                        decoration: textfilesStyle('Name'),
                      ),
                      cDivider(20),
                      TextFormField(
                        enabled: false,
                        // readOnly: true,
                        controller: _emailController = TextEditingController(
                            text: snapshot.data!["email"]),
                        decoration: textfilesStyle('Email'),
                      ),
                      cDivider(20),
                      TextFormField(
                        controller: _phoneController = TextEditingController(
                            text: snapshot.data!["phone"]),
                        decoration: textfilesStyle('Phone'),
                      ),
                      cDivider(20),
                      TextFormField(
                        controller: _addressController = TextEditingController(
                            text: snapshot.data!["address"]),
                        decoration: textfilesStyle('Address'),
                      ),
                      cDivider(70),
                      ElevatedButton(
                        onPressed: () {
                          //updateAuthEmail();
                          updateAuthName();
                          updateUserInfo();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserDetails(),
                            ),
                          );
                        },
                        style: buttonStyle,
                        child: Text(
                          'Update',
                          style: AppTextStyle.bodyTextStyle,
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Stack imgPicker(BuildContext context, data) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: AppColor.appMainColor,
            child: Text(
              data!["name"][0].toUpperCase(),
              style: AppTextStyle.headerStyle.copyWith(
                color: AppColor.appSecColor,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.appSecColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColor.appSecColor,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 30, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera,
                              color: AppColor.appMainColor,
                              size: 35,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image,
                              color: AppColor.appMainColor,
                              size: 35,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.appMainColor,
              ),
            ),
          ),
        ),
      ],
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