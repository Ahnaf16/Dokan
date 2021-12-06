import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appBackground,
        elevation: 1,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: AppColor.appMainColor,
            ),
          );
        }),
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
      body: const SafeArea(
        child: Center(
          child: Text(
            'Homepage',
            style: AllTextStyle.headerStyle,
          ),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: AppColor.fillColorL),
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center + const Alignment(0, -1),
                        child: const CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center + const Alignment(.3, 0),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.green,
                        ),
                      ),
                      Align(
                        alignment:
                            Alignment.bottomCenter + const Alignment(0, -.5),
                        child: const Text(
                          'Ahnaf Sakil',
                          style: AllTextStyle.bodyTextStyle,
                        ),
                      ),
                      Align(
                        alignment:
                            Alignment.bottomCenter + const Alignment(0, -.1),
                        child: const Text(
                          'ahnafsakil9@gmail.com',
                          style: AllTextStyle.smallTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Account'),
                leading: const Icon(Icons.person),
              ),
              ListTile(
                onTap: () {},
                title: const Text('Settings'),
                leading: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
