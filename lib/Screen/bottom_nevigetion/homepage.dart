import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Screen/detailspage.dart';
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

  bool loading = false;
  int dotPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SafeArea(
        child: SingleChildScrollView(
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
            //
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Text('Error loadimg data');
            }
            if (!snapshot.hasData) {
              return const Text('Unable to fetch data');
            }
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
                ],
              ),
            );
          }),
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
          const Padding(
            padding: EdgeInsets.symmetric(
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
                //
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: Center(
                      child: Row(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Details(
                                  pName: data["name"],
                                  pPrice: data["price"],
                                  pImg: data["img"],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(15),
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
