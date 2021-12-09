import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/material.dart';
import '../../export.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      appBar: AppBar(
        backgroundColor: AppColor.fillColorL,
        elevation: 1,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: AppColor.appMainColor,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColor.appMainColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Carousel(
              dotSize: 5,
              dotBgColor: Colors.transparent,
              images: [
                Image.network(
                  'https://expertphotography.b-cdn.net/wp-content/uploads/2021/01/landscape-photography-10_reupload.jpeg',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://www.adobe.com/content/dam/cc/us/en/creative-cloud/photography/discover/landscape-photography/CODERED_B1_landscape_P2d_714x348.jpg.img.jpg',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1611307742746-43cbea512c37?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bmF0dXJlJTIwbGFuZHNjYXBlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
