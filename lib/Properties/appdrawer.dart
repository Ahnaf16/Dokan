import 'package:dokan/export.dart';
import 'package:line_icons/line_icons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

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
                        alignment: Alignment.center + const Alignment(0, -1),
                        child: const CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center + const Alignment(.3, 0),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.green,
                        ),
                      ),
                      Align(
                        alignment:
                            Alignment.bottomCenter + const Alignment(0, -.5),
                        child: const Text(
                          'Ahnaf Sakil',
                          style: AppTextStyle.bodyTextStyle,
                        ),
                      ),
                      Align(
                        alignment:
                            Alignment.bottomCenter + const Alignment(0, -.1),
                        child: const Text(
                          'ahnafsakil9@gmail.com',
                          style: AppTextStyle.smallTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('My Orders'),
                leading: const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Voucher'),
                leading: const Icon(
                  Icons.local_offer_outlined,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Offers & rewords'),
                leading: const Icon(
                  LineIcons.trophy,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Help'),
                leading: const Icon(
                  LineIcons.question,
                  color: AppColor.appMainColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Settings'),
                leading: const Icon(
                  LineIcons.cog,
                  color: AppColor.appMainColor,
                ),
              ),
              const SizedBox(
                height: 470,
              ),
              ListTile(
                onTap: () {},
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
