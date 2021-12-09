// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import '../../export.dart';

class Navibar extends StatefulWidget {
  const Navibar({Key? key}) : super(key: key);

  @override
  State<Navibar> createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  var curentindex = 0;

  final neviPages = [
    Homepage(),
    Wishlist(),
    Cart(),
  ];

  List<Widget> naviIcons = [
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.shopping_cart),
  ];
  List<String> naviLebels = [
    'Home',
    'Wishlist',
    'Cart',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: neviPages[curentindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.fillColorL,
        elevation: 1,
        selectedItemColor: AppColor.appMainColor,
        unselectedItemColor: Color(0xFF4E4E4E),
        selectedFontSize: 15,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 30),
        showSelectedLabels: false,
        currentIndex: curentindex,
        items: [
          BottomNavigationBarItem(
            label: naviLebels[0],
            icon: naviIcons[0],
          ),
          BottomNavigationBarItem(
            label: naviLebels[1],
            icon: naviIcons[1],
          ),
          BottomNavigationBarItem(
            label: naviLebels[2],
            icon: naviIcons[2],
          ),
        ],
        onTap: (index) {
          setState(
            () {
              curentindex = index;
            },
          );
        },
      ),
    );
  }
}
