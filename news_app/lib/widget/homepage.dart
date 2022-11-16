// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/widget/const.dart';
import 'package:news_app/widget/custom_http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo = 1;
  String sortBy = 'popularity';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              iconSize: 35,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 230, 181, 35),
        title: Text(
          'News App',
          style: myStyle(30, Colors.black, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 184, 167, 119),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Prev'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 127, 139, 120)),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.transparent,
                          child: Center(child: Text('1')),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.white,
                          child: Center(child: Text('2')),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.transparent,
                          child: Center(child: Text('3')),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.transparent,
                          child: Center(child: Text('4')),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.transparent,
                          child: Center(child: Text('5')),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Next'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 127, 139, 120)),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder<List<Articles>>(
                  future: CustomeHttp()
                      .fetchAllNewsData(pageNo: pageNo, sortBy: sortBy),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Found Something error');
                    } else if (snapshot.data == null) {
                      return Text('No data found!');
                    }

                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Color.fromARGB(255, 230, 181, 35)),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              leading: Image.network(
                                  '${snapshot.data![index].urlToImage}'),
                              title: Text(
                                '${snapshot.data![index].title}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text('${snapshot.data![index].description}'),
                            ),
                          );
                        });
                  },
                )
              ],
            ),
          )),
    );
  }
}
