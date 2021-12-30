import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future sendUserNameDB(userName, userMail, phone, address) async {
  User? _auth = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection('UserInfo').doc(_auth!.email).set(
    {
      'name': userName,
      'email': userMail,
      'phone': phone,
      'address': address,
    },
  );
}
