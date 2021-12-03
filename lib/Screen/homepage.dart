// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
            icon: Icon(
              Icons.menu,
              color: AppColor.appMainColor,
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: AppColor.appMainColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
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
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0x1A519657)),
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Ahnaf Sakil',
                        style: AllTextStyle.bodyTextStyle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight + Alignment(0, .4),
                      child: Text(
                        'ahnafsakil9@gmail.com',
                        style: AllTextStyle.smallTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text('Account'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                onTap: () {},
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
