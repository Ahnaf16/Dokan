import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'herotest.dart';

class Details extends StatefulWidget {
  const Details(
      {Key? key, required this.pName, required this.pPrice, required this.pImg})
      : super(key: key);

  final String pName;
  final String pPrice;
  final List pImg;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  //

  Future addToCart() async {
    _fireStore
        .collection("User_cart")
        .doc(_user!.email)
        .collection("items")
        .doc(widget.pName)
        .set(
      {
        "name": widget.pName,
        "price": widget.pPrice,
        "imgs": widget.pImg,
      },
    ).then(
      (value) => Fluttertoast.showToast(msg: 'Added to cart'),
    );
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  int dots = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imgSlider(),
            cDivider(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.pName,
                style: AppTextStyle.bodyTextStyle,
              ),
            ),
            cDivider(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Price : ${widget.pPrice}',
                style: AppTextStyle.bodyTextStyle,
              ),
            ),
            cDivider(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Add Discription',
                style: AppTextStyle.bodyTextStyle,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          backgroundColor: AppColor.appMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          isExtended: true,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: 'wishlist has not implemented yet',
                    backgroundColor: AppColor.appSecColor,
                    textColor: AppColor.appSecColor,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                },
                icon: Icon(
                  Icons.favorite_outline,
                  color: AppColor.appSecColor,
                ),
              ),
              IconButton(
                onPressed: () async => await addToCart(),
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: AppColor.appSecColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material imgSlider() {
    return Material(
      elevation: 10,
      color: AppColor.appSecColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.pImg.length,
              options: CarouselOptions(
                initialPage: 1,
                enableInfiniteScroll: false,
                height: 200,
                viewportFraction: .54,
                onPageChanged: (index, reason) => setState(
                  () {
                    dots = index;
                  },
                ),
              ),
              itemBuilder: (context, index, realindex) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Herotest(
                            theIMG: widget.pImg[index],
                            tag: widget.pImg[index].toString(),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: widget.pImg[index].toString(),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppColor.appSecColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColor.appMainColor,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.pImg[index],
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            cDivider(10),
            dotIndicator(),
          ],
        ),
      ),
    );
  }

  Center dotIndicator() {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: dots,
        count: widget.pImg.length,
        effect: const SwapEffect(
          activeDotColor: AppColor.appMainColor,
          dotColor: Colors.grey,
          dotHeight: 10,
          dotWidth: 10,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.appBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.appMainColor,
        ),
      ),
      title: const Text(
        'Dokan',
        style: AppTextStyle.bodyTextStyle,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const SearchPage(),
            ),
          ),
          icon: const Icon(
            Icons.search,
            color: AppColor.appMainColor,
          ),
        )
      ],
    );
  }
}
