// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

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
  //

  int dotPosition = 0;

  List<String> imgForSlider = [];

  final _firestore = FirebaseFirestore.instance;

  getSliderImgs() async {
    try {
      QuerySnapshot qn = await _firestore.collection('Slider').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          imgForSlider.add(
            qn.docs[i]['img'],
          );
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSliderImgs();
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
            child: Column(
              children: [
                Material(
                  elevation: 15,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: CarouselSlider.builder(
                          itemCount: imgForSlider.length,
                          options: CarouselOptions(
                            height: 170,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) =>
                                setState(() => dotPosition = index),
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final showImg = imgForSlider[index];
                            return buildImg(showImg, index);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: buildIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
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
            child: Image.network(
              showImg,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: dotPosition,
        count: imgForSlider.length,
        effect: SwapEffect(
          activeDotColor: AppColor.appMainColor,
          dotColor: AppColor.appSecColor,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
