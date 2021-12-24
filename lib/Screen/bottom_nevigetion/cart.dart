import 'package:dokan/Properties/export.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColor.appBackground,
        body: Center(
          child: Text(
            'cart',
            style: AppTextStyle.headerStyle,
          ),
        ));
  }
}
