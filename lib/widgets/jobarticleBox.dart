import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lokaarpan/models/article.dart';
import 'package:html/dom.dart' as dom;

Widget jobarticleBox(BuildContext context, Article article, String heroId) {
  return ConstrainedBox(
    constraints: new BoxConstraints(
      minHeight: 160.0,
      maxHeight: 175.0,
    ),
    child: Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(20, 16, 0, 0),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.fromLTRB(110, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Html(
                              data: article.title.length > 70
                                  ? "<h1>" +
                                  article.title.substring(0, 70) +
                                  "...</h1>"
                                  : "<h1>" + article.title + "</h1>",
                              customTextStyle:
                                  (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "h1":
                                      return baseStyle.merge(Theme.of(context)
                                          .textTheme
                                          .headline1);
                                  }
                                }
                                return baseStyle;
                              }),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text( " ₹ " + article.money + " / Annum",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_city,
                                      color: Theme.of(context).canvasColor,
                                      size: 12.0,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      article.company,
                                      style:
                                      Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).canvasColor,
                                      size: 12.0,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      article.location,
                                      style:
                                      Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      color: Theme.of(context).canvasColor,
                                      size: 12.0,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      article.date,
                                      style:
                                      Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 170,
          width: 145,
          child: Card(
            child: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: article.image,
                  placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 6,
                          backgroundColor:
                          Theme.of(context).secondaryHeaderColor)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            margin: EdgeInsets.all(10),
          ),
        ),
        article.video != ""
            ? Positioned(
          left: 12,
          top: 12,
          child: Card(
            color: Theme.of(context).accentColor,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/play-button.png"),
            ),
            elevation: 8,
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
          ),
        )
            : Container(),
      ],
    ),
  );
}
