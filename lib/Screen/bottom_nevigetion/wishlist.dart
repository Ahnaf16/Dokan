// ignore_for_file: prefer_const_literals_to_create_immutables ,prefer_const_constructors

import 'package:dokan/Properties/export.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  //
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Text(
                  "hero testing",
                  style: AppTextStyle.bodyTextStyle,
                ),
                //.............................
                cDivider(30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                    color: AppColor.appSecColor,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: tapped ? 10 : MediaQuery.of(context).size.width,
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                tapped = !tapped;
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
