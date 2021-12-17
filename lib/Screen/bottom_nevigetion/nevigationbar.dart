// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../Properties/export.dart';

class Navibar extends StatefulWidget {
  final Function(User?) onClick;

  const Navibar({required this.onClick});

  @override
  State<Navibar> createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  var _curentindex = 0;

  int _toggle = 0;

  final neviPages = [
    const Homepage(),
    const Wishlist(),
    const Cart(),
  ];

  TextEditingController searchbarControl = TextEditingController();

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
      flexibleSpace: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Builder(
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
            ),
            Align(
              alignment: (_toggle == 0)
                  ? Alignment.bottomCenter
                  : Alignment.bottomCenter + const Alignment(0, -.4),
              child: AnimatedDefaultTextStyle(
                child: const Text('Dokan'),
                style: TextStyle(
                    fontSize: (_toggle == 0) ? 30 : 20,
                    color: AppColor.appMainColor),
                duration: const Duration(milliseconds: 200),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: searchBar(),
            ),
          ],
        ),
      ),
    );
  }

  Stack searchBar() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 47,
            width: (_toggle == 0) ? 45 : 370,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: (_toggle == 0)
                  ? null
                  : Border.all(
                      color: AppColor.appMainColor,
                      width: 1,
                    ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 0),
          child: AnimatedOpacity(
            opacity: (_toggle == 1) ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            curve: (_toggle == 1) ? Curves.elasticIn : Curves.easeOutQuart,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: (_toggle == 0) ? 45 : 380,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: TextField(
                  controller: searchbarControl,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppColor.appMainColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppColor.appMainColor,
                        width: 1,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            searchbarControl.clear();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColor.appMainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          child: IconButton(
            onPressed: () {
              setState(
                () {
                  if (_toggle == 0) {
                    _toggle = 1;
                  } else {
                    _toggle = 0;
                    searchbarControl.clear();
                  }
                },
              );
            },
            icon: Icon(
              (_toggle == 0) ? Icons.search : Icons.arrow_back_ios,
              color: AppColor.appMainColor,
            ),
          ),
          duration: const Duration(milliseconds: 350),
        )
      ],
    );
  }
}
