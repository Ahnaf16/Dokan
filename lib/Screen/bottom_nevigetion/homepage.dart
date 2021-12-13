import 'package:dokan/Properties/app_properties.dart';
import 'package:flutter/material.dart';
import '../../export.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController searchbarControl = TextEditingController();
  int _toggle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Builder(
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
              ),
              Align(
                alignment: (_toggle == 0)
                    ? Alignment.bottomCenter
                    : Alignment.bottomCenter + const Alignment(0, -.4),
                child: AnimatedDefaultTextStyle(
                  child: const Text('Dokan'),
                  style: TextStyle(
                      fontSize: (_toggle == 0) ? 30 : 20,
                      color: AppColor.appMainColor),
                  duration: const Duration(milliseconds: 200),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: searchBar(),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  //---------------------------searchbar--------------------------------------

  Widget searchBar() {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 47,
          width: (_toggle == 0) ? 45 : 380,
          curve: Curves.easeOut,
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 0),
          child: AnimatedOpacity(
            opacity: (_toggle == 1) ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            curve: (_toggle == 1) ? Curves.elasticIn : Curves.easeOutQuart,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: (_toggle == 0) ? 45 : 380,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: TextField(
                  controller: searchbarControl,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppColor.appMainColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppColor.appMainColor,
                        width: 1,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            searchbarControl.clear();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColor.appMainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          child: IconButton(
            onPressed: () {
              setState(
                () {
                  if (_toggle == 0) {
                    _toggle = 1;
                  } else {
                    _toggle = 0;
                    searchbarControl.clear();
                  }
                },
              );
            },
            icon: Icon((_toggle == 0) ? Icons.search : Icons.arrow_back_ios),
          ),
          duration: const Duration(milliseconds: 350),
        )
      ],
    );
  }
}
