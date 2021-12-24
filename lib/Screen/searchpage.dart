// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/Properties/export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //

  CollectionReference firestoreDocs =
      FirebaseFirestore.instance.collection('Products');

  TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Search',
          style: AppTextStyle.headerStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.appMainColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchControler,
                  style: AppTextStyle.bodyTextStyle,
                  decoration: textfilesStyle('search').copyWith(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.appMainColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchControler.clear();
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColor.appMainColor,
                      ),
                    ),
                  ),
                ),
                cDivider(20),
                getSearch()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded getSearch() {
    return Expanded(
      child: StreamBuilder(
        stream: firestoreDocs.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appMainColor,
              ),
            );
          }
          if (searchControler.text.isEmpty) {
            return const Text(
              'No search result',
              style: AppTextStyle.bodyTextStyle,
            );
          } else {
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object> element) =>
                        element["name"]
                            .toString()
                            .toLowerCase()
                            .contains(searchControler.text.toLowerCase()))
                    .map(
                  (QueryDocumentSnapshot<Object> data) {
                    final name = data["name"];
                    final img = data["img"][0];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        //color: AppColor.appSecColor,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColor.appMainColor, width: 2),
                          ),
                        ),
                        child: ListTile(
                          title: Text(name),
                          leading: Image.network(img),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}
