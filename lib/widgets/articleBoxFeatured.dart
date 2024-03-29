import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lokaarpan/models/article.dart';

Widget articleBoxFeatured(
    BuildContext context, Article article, String heroId) {
  return ConstrainedBox(
    constraints: new BoxConstraints(
        minHeight: 240.0, maxHeight: 250.0, minWidth: 360.0, maxWidth: 360.0),
    child: Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 260,
            width: 400,
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
              elevation: 1,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
      ],
    ),
  );
}
        /*Positioned(
          left: 20,
          top: 80,
          right: 20,
          child: Container(
            alignment: Alignment.bottomRight,
            height: 200,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    /*children: <Widget>[
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
                                    return baseStyle.merge(
                                        Theme.of(context).textTheme.headline1);
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
                              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                article.category,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
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
                                    style: Theme.of(context).textTheme.caption,
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
          ),
        ),

         */

         */
