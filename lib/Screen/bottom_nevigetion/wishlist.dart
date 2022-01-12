// ignore_for_file: prefer_const_literals_to_create_immutables ,prefer_const_constructors

import 'package:dokan/Properties/export.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Text(
                  "hero testing",
                  style: AppTextStyle.bodyTextStyle,
                ),
                //.............................
              ],
            ),
          ),
        ),
      ),
    );
  }
}
