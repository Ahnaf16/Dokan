// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../export.dart';

class Navibar extends StatefulWidget {
  const Navibar({Key? key}) : super(key: key);

  @override
  State<Navibar> createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  var _curentindex = 0;

  final neviPages = [
    Homepage(),
    Wishlist(),
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: neviPages[_curentindex],
      bottomNavigationBar: GNav(
        gap: 15,
        rippleColor: AppColor.fillColorL,
        curve: Curves.easeInQuad,
        duration: Duration(milliseconds: 400),
        color: Colors.black54,
        activeColor: AppColor.appMainColor,
        tabBackgroundColor: AppColor.appSecColor,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        tabMargin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        backgroundColor: AppColor.appBackground,
        selectedIndex: _curentindex,
        onTabChange: (index) {
          setState(
            () {
              _curentindex = index;
            },
          );
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Wishlist',
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}
