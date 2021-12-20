// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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

  List products = [];
  List<String> loading = [
    'https://c.tenor.com/tEBoZu1ISJ8AAAAC/spinning-loading.gif',
    'loading'
  ];

  @override
  void initState() {
    getProdacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: Center(
          child: Column(
        children: [
          Text(
            'Cart',
            style: AppTextStyle.headerStyle,
          ),
        ],
      )),
    );
  }
}
