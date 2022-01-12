import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';

class CustomDrawer extends StatefulWidget {
  final Function(User?) onlogout;

  const CustomDrawer({Key? key, required this.onlogout}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    widget.onlogout(null);
  }

  Future getUID() async {
    return FirebaseAuth.instance.currentUser;
  }

//show user data
  getUserData() {
    return FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(_currentUser!.email)
        .snapshots();
  }

  final User? _currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: AppColor.appSecColor.withOpacity(.2),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: AppColor.appSecColor),
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                'Unexpacted Error',
                                style: AppTextStyle.errorText,
                              );
                            }
                            if (!snapshot.hasData) {
                              return const LinearProgressIndicator(
                                color: AppColor.appMainColor,
                              );
                            } else {
                              //final userdata = snapshot.data;
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserDetails(
                                          userName: snapshot.data!["name"][0]
                                              .toString()
                                              .toUpperCase(),
                                        ),
                                      ),
                                    ).then((value) => setState(() {})),
                                    child: Align(
                                      alignment: Alignment.center +
                                          const Alignment(0, -1),
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor: AppColor.appMainColor,
                                        child: snapshot.data!["dp"] != null
                                            ? ClipOval(
                                                child: Image.network(
                                                  snapshot.data!["dp"],
                                                ),
                                              )
                                            : Text(
                                                snapshot.data!["name"] == null
                                                    ? 'User'
                                                    : snapshot.data!["name"][0]
                                                        .toString()
                                                        .toUpperCase(),
                                                style: AppTextStyle.headerStyle
                                                    .copyWith(
                                                  color: AppColor.appSecColor,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center +
                                        const Alignment(.3, 0),
                                    child: const Icon(
                                      Icons.verified,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center +
                                        const Alignment(0, .5),
                                    child: Text(
                                      snapshot.data!["name"] ?? 'User',
                                      style: AppTextStyle.bodyTextStyle,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center +
                                        const Alignment(0, .9),
                                    child: Text(
                                      snapshot.data!["email"] ?? 'Email',
                                      style: AppTextStyle.smallTextStyle,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                  'My Orders',
                  style: AppTextStyle.smallTextStyle,
                ),
                leading: const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                  'Voucher',
                  style: AppTextStyle.smallTextStyle,
                ),
                leading: const Icon(
                  Icons.local_offer_outlined,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                  'Offers & rewords',
                  style: AppTextStyle.smallTextStyle,
                ),
                leading: const Icon(
                  LineIcons.trophy,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                  'Help',
                  style: AppTextStyle.smallTextStyle,
                ),
                leading: const Icon(
                  LineIcons.question,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text(
                  'Settings',
                  style: AppTextStyle.smallTextStyle,
                ),
                leading: const Icon(
                  LineIcons.cog,
                  color: AppColor.appMainColor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              ListTile(
                onTap: () {
                  logOut();
                },
                title: Text(
                  'Log out',
                  style: AppTextStyle.smallTextStyle.copyWith(
                    color: AppColor.appMainColor,
                  ),
                ),
                leading: const Icon(
                  LineIcons.alternateSignOut,
                  color: AppColor.appMainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
