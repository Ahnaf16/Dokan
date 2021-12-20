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

  getProdacts() async {
    try {
      QuerySnapshot qn = await _firestore.collection('Products').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          products.add({
            "product-name": qn.docs[i]["name"],
            "product-price": qn.docs[i]["price"],
            "product-img": qn.docs[i]["img"],
          });
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  final _firestore = FirebaseFirestore.instance;

  int dotPosition = 0;

  List<String> imgForSlider = [];
  List products = [];
  List<String> loading = [
    'https://c.tenor.com/tEBoZu1ISJ8AAAAC/spinning-loading.gif',
    'loading'
  ];

  @override
  void initState() {
    getSliderImgs();
    getProdacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 135,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: .8,
                          onPageChanged: (index, reason) =>
                              setState(() => dotPosition = index),
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final showImg = imgForSlider.isEmpty
                              ? loading[index]
                              : imgForSlider[index];
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
              cDivider(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Featured Products',
                  style: AppTextStyle.bodyTextStyle,
                ),
              ),
              cDivider(10),
              productGrid(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'All Products',
                  style: AppTextStyle.bodyTextStyle,
                ),
              ),
              productGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded productGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 1),
          itemCount: products.isEmpty ? 1 : products.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  side: BorderSide(color: AppColor.appMainColor, width: 2)),
              elevation: 10,
              child: SizedBox(
                //color: Colors.grey,
                height: 200,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(products.isEmpty
                            ? loading[0]
                            : products[index]["product-img"][0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '${products.isEmpty ? loading[1] : products[index]["product-name"]}',
                          style: AppTextStyle.bodyTextStyle,
                        ),
                      ),
                      Text(
                        '${products.isEmpty ? loading[1] : products[index]["product-price"]}',
                        style: AppTextStyle.bodyTextStyle,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
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
          image: DecorationImage(
            image: NetworkImage(
              showImg,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: dotPosition,
        count: imgForSlider.isEmpty ? 1 : imgForSlider.length,
        effect: SwapEffect(
          activeDotColor: AppColor.appMainColor,
          dotColor: AppColor.appSecColor,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
