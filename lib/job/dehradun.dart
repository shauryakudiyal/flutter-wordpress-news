import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:lokaarpan/common/constants.dart';
import 'package:lokaarpan/common/helpers.dart';
import 'package:lokaarpan/models/article.dart';
import 'package:lokaarpan/pages/category_articles.dart';
import 'package:lokaarpan/single_articles/featured_article.dart';
import 'package:lokaarpan/single_articles/job_article.dart';
import 'package:lokaarpan/widgets/articleBoxFeatured.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:lokaarpan/widgets/jobarticleBox.dart';


class DehradunJobArticles extends StatefulWidget {
  @override
  _DehradunJobArticlesState createState() => _DehradunJobArticlesState();
}

class _DehradunJobArticlesState extends State<DehradunJobArticles> {
  List<dynamic> featuredArticles = [];
  List<dynamic> latestArticles = [];
  Future<List<dynamic>> _futureLastestArticles;
  Future<List<dynamic>> _futureFeaturedArticles;
  ScrollController _controller;
  int page = 1;
  bool _infiniteStop;

  @override
  void initState() {
    super.initState();
    page = 1;
    _futureLastestArticles = fetchLatestArticles(page);
    _futureFeaturedArticles = fetchFeaturedArticles();
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller.addListener(_scrollListener);
    _infiniteStop = false;
  }

  void _checkforForceUpdate(int lastId) async {
    if (!this.mounted) return;
    try {
      String requestUrl =
          "$Jobs_URL/wp-json/wp/v2/posts?page=$page&per_page=1&_fields=id";
      var response = await http.get(
        requestUrl,
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)[0]['id'] != lastId) {
          customDioCacheManager.clearAll();
          setState(() {
            latestArticles = [];
            page = 1;
            _futureLastestArticles = fetchLatestArticles(page);
          });
        }
      }
    } on SocketException {
      print('No Internet connection');
    }
  }

  _scrollListener() {
    if (!this.mounted) return;

    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      setState(() {
        page += 1;
        _futureLastestArticles = fetchLatestArticles(page);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<List<dynamic>> fetchLatestArticles(int page) async {
    if (!this.mounted) return latestArticles;

    try {
      String requestUrl =
          "$Jobs_URL/wp-json/wp/v2/posts?page=$page&per_page=10&_fields=id,date,title,content,custom,link,mobile,money,location,company";
      Response response = await customDio.get(
        requestUrl,
        options:
        buildCacheOptions(Duration(days: 3), maxStale: Duration(days: 7)),
      );

      if (response.statusCode == 200) {
        setState(() {
          latestArticles
              .addAll(response.data.map((m) => Article.fromJson(m)).toList());
          if (latestArticles.length % 10 != 0) {
            _infiniteStop = true;
          }
        });
        if (page == 1) {
          _checkforForceUpdate(latestArticles[0].id);
        }

        return latestArticles;
      }
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ("Server is not reachable. Please verify your internet connection and try again");
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 400) {
          setState(() {
            _infiniteStop = true;
          });
        } else {
          print(e.message);
          print(e.request);
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw ('No Internet Connection.');
        }
      } else {
        throw ("Problem connecting to the server. Please try again.");
      }
    }

    return latestArticles;
  }

  Future<List<dynamic>> fetchFeaturedArticles() async {
    if (!this.mounted) return featuredArticles;
    try {
      String requestUrl =
          "$WORDPRESS_URL/wp-json/wp/v2/posts?categories[]=$FEATURED_ID&per_page=10&_fields=id,date,title,content,custom,link,mobile,money,location,company";
      Response response = await customDio.get(
        requestUrl,
        options:
        buildCacheOptions(Duration(days: 3), maxStale: Duration(days: 7)),
      );

      if (this.mounted && response.statusCode == 200) {
        setState(() {
          featuredArticles
              .addAll(response.data.map((m) => Article.fromJson(m)).toList());
        });
        return featuredArticles;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.request);
    }
    return featuredArticles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          child: SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                featuredPost(_futureFeaturedArticles),
                jobCategories(context),
                latestPosts(_futureLastestArticles)
              ],
            ),
          ),
        ));
  }

  Widget latestPosts(Future<List<dynamic>> latestArticles) {
    return FutureBuilder<List<dynamic>>(
      future: latestArticles,
      builder: (context, articleSnapshot) {
        if (articleSnapshot.hasData) {
          if (articleSnapshot.data.length == 0) return Container();
          return Column(
            children: <Widget>[
              ListView.builder(
                  itemCount: articleSnapshot.data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Article item = articleSnapshot.data[index];
                    Random random = new Random();
                    final randNum = random.nextInt(10000);
                    final heroId = item.id.toString() + randNum.toString();
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobArticle(item, heroId),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          ENABLE_ADS && index % 15 == 0
                              ? Container(
                            margin: EdgeInsets.fromLTRB(10, 4, 4, 0),
                            child: Card(
                              elevation: 6,
                              child: AdmobBanner(
                                adUnitId: ADMOB_BANNER_ID_1,
                                adSize: AdmobBannerSize.LEADERBOARD,
                              ),
                            ),
                          )
                              : Container(),
                          jobarticleBox(context, item, heroId),
                        ],
                      ),
                    );
                  }),
              !_infiniteStop
                  ? Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: Loading(
                      indicator: BallBeatIndicator(),
                      size: 60.0,
                      color: Theme.of(context).accentColor))
                  : Container()
            ],
          );
        } else if (articleSnapshot.hasError) {
          return Container(
              height: 300,
              alignment: Alignment.center,
              child: Text("${articleSnapshot.error}"));
        }
        return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Loading(
                indicator: BallBeatIndicator(),
                size: 60.0,
                color: Theme.of(context).accentColor));
      },
    );
  }


  Widget jobCategories(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(1),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 5,
      children: List.generate(CATEGORIES.length, (index) {
        var cat = CATEGORIES[index];
        var name = cat[0];
        var image = cat[1];
        var catId = cat[2];

        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryArticles(catId, name),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(width: 100, height: 45, child: Image.asset(image)),
                  Spacer(),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget featuredPost(Future<List<dynamic>> featuredArticles) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<dynamic>>(
        future: featuredArticles,
        builder: (context, articleSnapshot) {
          if (articleSnapshot.hasData) {
            if (articleSnapshot.data.length == 0) return Container();
            return Row(
                children: articleSnapshot.data.map((item) {
                  Random random = new Random();
                  final randNum = random.nextInt(10000);
                  final heroId = item.id.toString() + randNum.toString();
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeaturedArticle(item, heroId),
                          ),
                        );
                      },
                      child: articleBoxFeatured(context, item, heroId));
                }).toList());
          } else if (articleSnapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/no-internet.png",
                    width: 250,
                  ),
                  Text("No Internet Connection."),
                  FlatButton.icon(
                    icon: Icon(Icons.refresh),
                    label: Text("Reload"),
                    onPressed: () {
                      _futureLastestArticles = fetchLatestArticles(page);
                      _futureFeaturedArticles = fetchFeaturedArticles();
                    },
                  )
                ],
              ),
            );
          }
          return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 290,
              child: Loading(
                  indicator: BallBeatIndicator(),
                  size: 60.0,
                  color: Theme.of(context).accentColor));
        },
      ),
    );
  }
}
const List<dynamic> CATEGORIES = [
  ["Marketing", "assets/boxed/lifestyle.png", 7248],
  ["Fashion", "assets/boxed/fashion.png", 12],
  ["Music", "assets/boxed/music.png", 14],
  ["Photography", "assets/boxed/photography.png", 15],
  ["Sport", "assets/boxed/sport.png", 13],
  ["World", "assets/boxed/world.png", 11],
  ["Health", "assets/boxed/health.png", 8],
  ["Travel", "assets/boxed/travel.png", 7],
  ["Recipies", "assets/boxed/recipies.png", 10],
];