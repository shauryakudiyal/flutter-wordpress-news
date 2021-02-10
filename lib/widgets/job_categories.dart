import 'package:flutter/material.dart';
import 'package:lokaarpan/common/constants.dart';
import 'package:lokaarpan/pages/category_articles.dart';

Widget jobCategories(BuildContext context) {
  return GridView.count(
    padding: EdgeInsets.all(16),
    shrinkWrap: true,
    physics: ScrollPhysics(),
    crossAxisCount: 4,
    children: List.generate(Job_CATEGORIES.length, (index) {
      var cat = Job_CATEGORIES[index];
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
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
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
