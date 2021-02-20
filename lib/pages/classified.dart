import 'package:flutter/material.dart';
import 'package:lokaarpan/classified/Haridwar.dart';
import 'package:lokaarpan/classified/dehradun.dart';
import 'package:lokaarpan/classified/haldwani.dart';
import 'package:lokaarpan/classified/rishikesh.dart';
import 'package:lokaarpan/classified/roorkee.dart';



class Classified extends StatefulWidget {
  final Widget child;
  Classified({Key key, this.child}) : super(key: key);
  _ClassifiedState createState() => _ClassifiedState();
}


class _ClassifiedState extends State<Classified> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Image(
              image: Theme.of(context).brightness == Brightness.light
                  ? AssetImage('assets/icon.png')
                  : AssetImage('assets/icon-dark.png'),
              height: 45,
            ),
            elevation: 5,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Theme.of(context).primaryColorDark,
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
                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Rishikesh',
                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Haridwar',
                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Roorkee',
                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Haldwani',
                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              DehradunClassified(0xffff5722),
              RishikeshClassified(0xffff5722),
              HaridwarClassified(0xffff5722),
              RoorkeeClassified(0xffff5722),
              HaldwaniClassified(0xffff5722),
            ],
          )),
    );
  }
}

