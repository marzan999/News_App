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
                  height: 80,
                  color: Colors.yellow,
                ),
                Container(
                  height: 80,
                  color: Colors.yellow,
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
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(
                                '${snapshot.data![index].urlToImage}'),
                            title: Text(
                              '${snapshot.data![index].title}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text('${snapshot.data![index].description}'),
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
