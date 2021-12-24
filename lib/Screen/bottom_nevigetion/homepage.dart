// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Properties/export.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //

  final _firestore = FirebaseFirestore.instance;

  Future getSliderImg() async {
    QuerySnapshot qn = await _firestore.collection('Slider').get();
    return qn.docs;
  }

  Future getProdacts() async {
    QuerySnapshot qn = await _firestore.collection('Products').get();
    return qn.docs;
  }

  int dotPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imgSlider(),
              cDivider(30),
              productList(),
            ],
          ),
        ),
      ),
    );
  }

  Material imgSlider() {
    return Material(
      color: AppColor.appSecColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      elevation: 15,
      child: FutureBuilder(
        future: getSliderImg(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appMainColor,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('Error loadimg data');
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Text('No network');
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 15,
              ),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: snapshot.data.length,
                    options: CarouselOptions(
                      height: 135,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: .8,
                      onPageChanged: (index, reason) => dotPosition = index,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      DocumentSnapshot data = snapshot.data[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColor.appSecColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColor.appMainColor,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              data["img"],
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    },
                  ),
                  cDivider(15),
                  AnimatedSmoothIndicator(
                    activeIndex: dotPosition,
                    count: snapshot.data.length,
                    effect: const SwapEffect(
                      activeDotColor: AppColor.appMainColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Material productList() {
    return Material(
      color: AppColor.appSecColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      elevation: 15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              'Featured Products',
              style: AppTextStyle.bodyTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5).copyWith(top: 0),
            child: FutureBuilder(
              future: getProdacts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.appMainColor,
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 280,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot data = snapshot.data[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(15),
                            side: const BorderSide(
                                color: AppColor.appMainColor, width: 2),
                          ),
                          elevation: 0,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 160,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: AppColor.appSecColor,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          data["img"][0],
                                        ),
                                        // fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft +
                                    const Alignment(0, .6),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  child: Text(
                                    data["name"],
                                    style: AppTextStyle.smallTextStyle,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft +
                                    const Alignment(0, -.1),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Text(
                                    data["price"],
                                    style: AppTextStyle.smallTextStyle,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
