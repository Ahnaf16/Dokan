// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Properties/export.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final imgs = [
    'assets/banar2.jpeg',
    'assets/banar3.jpeg',
    'assets/banar4.jpeg',
    'assets/banar5.jpeg',
    'assets/banar6.jpeg',
  ];
  int activeIndex = 0;

  final userCollection =
      FirebaseFirestore.instance.collection('UserInfo').snapshots();

  Future getUID() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Material(
              elevation: 15,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: CarouselSlider.builder(
                      itemCount: imgs.length,
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: .7,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final showImg = imgs[index];
                        return buildImg(showImg, index);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: buildicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImg(String showImg, int index) => Container(
        decoration: BoxDecoration(
          color: AppColor.appSecColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColor.appMainColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              showImg,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget buildicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgs.length,
        effect: SwapEffect(
          activeDotColor: AppColor.appMainColor,
          dotColor: AppColor.appSecColor,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
