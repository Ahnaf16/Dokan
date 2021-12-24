import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  //

  Future getSliderImg() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection('Slider').get();
    return qn.docs;
  }

  //
  Future getProdacts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection('Products').get();
    return qn.docs;
  }

  int dotPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: Column(
        children: const [
          Text(
            'wish',
            style: AppTextStyle.headerStyle,
          ),
        ],
      ),
    );
  }
}
