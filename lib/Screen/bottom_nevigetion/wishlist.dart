import 'package:dokan/Properties/export.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.appBackground,
      body: Center(
        child: Text(
          'Wishlist',
          style: AppTextStyle.headerStyle,
        ),
      ),
    );
  }
}
