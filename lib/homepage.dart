import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_newsapi/categorydata.dart';
import 'package:flutter_application_newsapi/model/ctegory.dart';
import 'package:flutter_application_newsapi/model/newsapi.dart';
import 'package:flutter_application_newsapi/newsdata.dart';

import 'categorydetail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _isloading = true;

  getnews() async {
    News newsdata = News();
    await newsdata.getNews();

    articles = newsdata.datatobesavedin;
    setState(() {
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getnews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment
                .center, // this is to bring the row text in center
            children: [
              Text(
                "Flutter ",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "News",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ],
          ),
        ),
        body: _isloading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 70.0,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (contex, index) {
                              // return ListTile(
                              //   leading: Text(categories[index].categoryName),
                              //   trailing: Text(categories[index].imageUrl),
                              // );
                              return categorytile(
                                  categoryName: categories[index].categoryName,
                                  imageUrl: categories[index].imageUrl);
                            }),
                      ),
                      Divider(
                        thickness: 10,
                        color: Colors.yellow,
                      ),
                      Container(
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return newstemp(
                                  urlToImage: articles[index].urlToImage,
                                  title: articles[index].title,
                                  description: articles[index].description);
                            }),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget categorytile({String? categoryName, String? imageUrl}) {
    return GestureDetector(
      onTap: () {
        print("hello");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => categorydetail(category: categoryName!)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl!,
                height: 150,
                width: 200,
              )),
          Container(
            alignment: Alignment.center,
            width: 170,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryName!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget newstemp(
    {String? title, String? description, String? url, String? urlToImage}) {
  return Column(
    children: [
      Image.network(urlToImage!, width: 380, height: 200, fit: BoxFit.cover),
      Text(
        title!,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        description!,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // get our categories list

//   List<CategoryModel> categories = <CategoryModel>[];

//   // get our newslist first

//   List<ArticleModel> articles = <ArticleModel>[];
//   bool _loading = true;

//   getNews() async {
//     News newsdata = News();
//     await newsdata.getNews();
//     articles = newsdata.datatobesavedin;
//     setState(() {
//       _loading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     categories = getCategories();
//     getNews();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment
//               .center, // this is to bring the row text in center
//           children: <Widget>[
//             Text(
//               "Flutter ",
//               style: TextStyle(color: Colors.black),
//             ),
//             Text(
//               "News",
//               style: TextStyle(color: Colors.blueAccent),
//             ),
//           ],
//         ),
//       ),

//       // category widgets
//       body: _loading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               child: Container(
//                 color: Colors.white,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       height: 70.0,
//                       padding: EdgeInsets.symmetric(horizontal: 12.0),
//                       child: ListView.builder(
//                         itemCount: categories.length,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           return CategoryTile(
//                             imageUrl: categories[index].imageUrl,
//                             categoryName: categories[index].categoryName,
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       child: ListView.builder(
//                         itemCount: articles.length,
//                         physics: ClampingScrollPhysics(),
//                         shrinkWrap: true, // add this otherwise an error
//                         itemBuilder: (context, index) {
//                           return NewsTemplate(
//                             urlToImage: articles[index].urlToImage,
//                             title: articles[index].title,
//                             description: articles[index].description,
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class CategoryTile extends StatelessWidget {
//   final String? categoryName, imageUrl;
//   CategoryTile({this.categoryName, this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigator.push(context, MaterialPageRoute(
//         // builder: (context) => CategoryFragment(
//         //   category: categoryName.toLowerCase(),
//         // ),
//         // ));
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 16),
//         child: Stack(
//           children: <Widget>[
//             ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Image.network(
//                   imageUrl!,
//                   fit: BoxFit.fill,
//                 )),
//             Container(
//               alignment: Alignment.center,
//               width: 170,
//               height: 90,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 color: Colors.black26,
//               ),
//               child: Text(
//                 categoryName!,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // creating template for news

// class NewsTemplate extends StatelessWidget {
//   String? title, description, url, urlToImage;
//   NewsTemplate({this.title, this.description, this.urlToImage, this.url});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(16),
//       child: Column(
//         children: <Widget>[
//           ClipRRect(
//               borderRadius: BorderRadius.circular(6),
//               child: Image.network(
//                 urlToImage!,
//                 fit: BoxFit.cover,
//               )),
//           SizedBox(height: 8),
//           Text(
//             title!,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//                 color: Colors.black),
//           ),
//           SizedBox(height: 8),
//           Text(
//             description!,
//             style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
//           ),
//         ],
//       ),
//     );
//   }
// }
