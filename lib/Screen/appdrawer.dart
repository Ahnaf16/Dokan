import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';

class CustomDrawer extends StatelessWidget {
  final Function(User?) onlogout;

  CustomDrawer({required this.onlogout});

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    onlogout(null);
  }

  Future getUID() async {
    return FirebaseAuth.instance.currentUser;
  }

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
                        child: FutureBuilder(
                          future: getUID(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final userdata = snapshot.data;
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserDetails(),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center +
                                          const Alignment(0, -1),
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor: AppColor.appMainColor,
                                        child: Text(
                                          userdata.displayName == null
                                              ? 'name'
                                              : userdata.displayName[0]
                                                  .toString()
                                                  .toUpperCase(),
                                          style:
                                              AppTextStyle.headerStyle.copyWith(
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
                                      userdata.displayName ?? 'name',
                                      style: AppTextStyle.bodyTextStyle,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center +
                                        const Alignment(0, .9),
                                    child: Text(
                                      userdata.email,
                                      style: AppTextStyle.smallTextStyle,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Text('error');
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
