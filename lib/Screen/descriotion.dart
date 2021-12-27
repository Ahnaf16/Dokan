// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dokan/Properties/export.dart';

import 'searchpage.dart';

class Details extends StatelessWidget {
  const Details(
      {required this.pName, required this.pPrice, required this.pImg});

  final String pName;
  final String pPrice;
  final List pImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImgs(context),
            cDivider(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                pName,
                style: AppTextStyle.bodyTextStyle,
              ),
            ),
            cDivider(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Price : $pPrice',
                style: AppTextStyle.bodyTextStyle,
              ),
            ),
            cDivider(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Add Discription',
                style: AppTextStyle.bodyTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Material productImgs(context) {
    return Material(
      color: AppColor.appSecColor,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: pImg.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  side:
                      const BorderSide(color: AppColor.appMainColor, width: 2),
                ),
                child: Image.network(
                  pImg[index],
                ),
              );
            },
          ),
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
        icon: Icon(
          Icons.arrow_back,
          color: AppColor.appMainColor,
        ),
      ),
      title: Text(
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
              builder: (context) => SearchPage(),
            ),
          ),
          icon: Icon(
            Icons.search,
            color: AppColor.appMainColor,
          ),
        )
      ],
    );
  }
}
