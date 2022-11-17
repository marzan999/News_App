// import 'package:flutter/material.dart';
// import 'package:news_app/model/news_model.dart';
// import 'package:news_app/screens/custom_http.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();
//   List<Articles> searchList = [];
//   FocusNode focusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//             child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 60,
//                 child: TextField(
//                   focusNode: focusNode,
//                   controller: searchController,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                           onPressed: () {}, icon: Icon(Icons.search))),
//                   onEditingComplete: () async {
//                     searchList = await CustomeHttp().fetchSearchsData(
//                         query: searchController.text.toString());
//                     setState(() {});
//                   },
//                 ),
//               )
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/const.dart';
import 'package:news_app/screens/custom_http.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<Articles> searchList = [];
  FocusNode focusNode = FocusNode();
  List<String> sarchKeyword = [
    "World",
  ];

  bool isleaoding = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isleaoding == true,
        blur: 0.5,
        opacity: 0.5,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(22),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: 60,
                  child: TextField(
                    focusNode: focusNode,
                    controller: searchController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              searchList = [];
                              searchController.clear();
                              setState(() {});
                            },
                            icon: Icon(Icons.close))),
                    onEditingComplete: () async {
                      searchList = await CustomeHttp()
                          .fetchSearchsData(query: searchController.text);
                      setState(() {});
                    },
                  ),
                ),
                searchList.isEmpty
                    ? SizedBox(
                        height: 100,
                        child: MasonryGridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          itemCount: sarchKeyword.length,
                          crossAxisSpacing: 4,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  isleaoding = true;
                                });
                                searchController.text = sarchKeyword[index];
                                searchList = await CustomeHttp()
                                    .fetchSearchsData(
                                        query: sarchKeyword[index]);
                                setState(() {
                                  isleaoding = false;
                                });
                              },
                              child: Text("${sarchKeyword[index]}"),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: searchList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            Image.network("${searchList[index].urlToImage}"),
                        title: Text("${searchList[index].title}"),
                        subtitle: Text(
                          "${searchList[index].description}",
                          style: myStyle(14, Colors.black54),
                        ),
                      );
                    })
              ],
            )),
          ),
        ),
      ),
    );
  }
}
