import 'package:dokan/export.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Center(
        child: Text(
          'Wishlist',
          style: AllTextStyle.headerStyle,
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
