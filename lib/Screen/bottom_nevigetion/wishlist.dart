import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: const [
              Text(
                'wishlist',
                style: AppTextStyle.headerStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
