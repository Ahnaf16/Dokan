// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dokan/Properties/export.dart';

class Herotest extends StatelessWidget {
  //
  const Herotest({Key? key, required this.theIMG, required this.tag})
      : super(key: key);

  final String theIMG;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.of(context).size.height;
    final scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: AppColor.appMainColor,
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Image.network(
            theIMG,
            height: scrHeight,
            width: scrWidth,
          ),
        ),
      ),
    );
  }
}
