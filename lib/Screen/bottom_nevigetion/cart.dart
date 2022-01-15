import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../detailspage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
//

  showCartItem() {
    return _fireStore
        .collection("User_cart")
        .doc(_user!.email)
        .collection("items")
        .snapshots();
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SafeArea(
        child: StreamBuilder(
          stream: showCartItem(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.appMainColor,
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'No Cart Item',
                  style: AppTextStyle.errorText,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                //
                DocumentSnapshot _docs = snapshot.data!.docs[index];

                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: AppColor.appSecColor,
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Details(
                              pName: _docs["name"],
                              pPrice: _docs["price"],
                              pImg: _docs["imgs"],
                            ),
                          ),
                        ),
                        leading: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            _docs["imgs"][0],
                          ),
                        ),
                        title: Text(
                          _docs["name"],
                          style: AppTextStyle.smallTextStyle,
                        ),
                        subtitle: Text(
                          _docs["price"],
                          style: AppTextStyle.smallTextStyle,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _fireStore
                                .collection("User_cart")
                                .doc(_user!.email)
                                .collection("items")
                                .doc(_docs.id)
                                .delete()
                                .then(
                                  (value) =>
                                      Fluttertoast.showToast(msg: 'Removed'),
                                );
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: AppColor.appMainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
