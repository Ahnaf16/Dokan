// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Screen/searchpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../Properties/export.dart';
import 'homepage.dart';

class Navibar extends StatefulWidget {
  final Function(User?) onClick;

  const Navibar({Key? key, required this.onClick}) : super(key: key);

  @override
  State<Navibar> createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  var _curentindex = 0;

  final neviPages = [
    const Homepage(),
    const Wishlist(),
    const Cart(),
  ];
  CollectionReference firestoreDocs =
      FirebaseFirestore.instance.collection('Products');

  TextEditingController searchControler = TextEditingController();

  onClicked(userCred) {
    user = userCred;
    widget.onClick(user);
  }

  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: CustomDrawer(
        onlogout: (userCred) => onClicked(userCred),
      ),
      body: neviPages[_curentindex],
      bottomNavigationBar: GNav(
        gap: 15,
        rippleColor: AppColor.fillColorL,
        curve: Curves.easeInQuad,
        duration: Duration(milliseconds: 400),
        color: AppColor.appMainColor.withOpacity(0.5),
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColor.appBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: AppColor.appMainColor,
            ),
          );
        },
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
