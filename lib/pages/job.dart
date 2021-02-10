import 'package:flutter/material.dart';
import 'package:lokaarpan/job/dehradun.dart';
import 'package:lokaarpan/job/haldwani.dart';
import 'package:lokaarpan/job/haridwar.dart';
import 'package:lokaarpan/job/rishikesh.dart';
import 'package:lokaarpan/job/roorkee.dart';


class HomePage extends StatefulWidget {
  final Widget child;
  HomePage({Key key, this.child}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              onTap: (index){
                setState(() {
                  switch (index) {
                    case 0:

                      break;
                    case 1:

                      break;
                    case 2:

                      break;
                    case 3:

                      break;
                    case 4:

                      break;
                    default:
                  }
                });
              },
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'Dehradun',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Haridwar',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Rishikesh',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Roorkee',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Haldwani',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              DehradunJobArticles(),
              HaridwarJobArticles(),
              RishikeshJobArticles(),
              RoorkeeJobArticles(),
              HaldwaniJobArticles(),
            ],
          )),
    );
  }
}
