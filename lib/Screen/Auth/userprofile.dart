// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/edituserdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetails extends StatefulWidget {
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
//
  User? _currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cDivider(20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColor.appMainColor,
                        child: Text(
                          'd',
                          style: AppTextStyle.headerStyle.copyWith(
                            color: AppColor.appSecColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  cDivider(30),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(15),
                    ),
                    color: AppColor.appSecColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _currentUser!.displayName.toString(),
                              style: AppTextStyle.bodyTextStyle,
                            ),
                          ),
                          cDivider(30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _currentUser!.email.toString(),
                              style: AppTextStyle.bodyTextStyle,
                            ),
                          ),
                          cDivider(30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phone',
                              style: AppTextStyle.bodyTextStyle,
                            ),
                          ),
                          cDivider(30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Address',
                              style: AppTextStyle.bodyTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  cDivider(70),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (_) => EditUserDetails(),
                        ),
                      );
                    },
                    style: buttonStyle,
                    child: Text(
                      'Edit Details',
                      style: AppTextStyle.bodyTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
