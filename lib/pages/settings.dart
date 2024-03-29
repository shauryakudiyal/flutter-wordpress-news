import 'package:flutter/material.dart';
import 'package:lokaarpan/common/helpers.dart';
import 'package:lokaarpan/pages/favoutite_articles.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline2,
        ),
        elevation: 5,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image(
                image: Theme.of(context).brightness == Brightness.light
                    ? AssetImage('assets/icon.png')
                    : AssetImage('assets/icon-dark.png'),
                height: 50,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                "Version 1.0.0 \n lokaarpan.com \n Lokaarpan news , classified , jobs app",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Divider(
              color: Theme.of(context).backgroundColor,
              height: 10,
              thickness: 2,
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteArticles(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/favourite.png",
                      width: 30,
                    ),
                    title: Text('Favourite'),
                    subtitle: Text(
                      "See the saved news article",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/contact.png",
                    width: 30,
                  ),
                  title: Text('Contact'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          const url = 'https://lokaarpan.com';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text("lokaarpan.com",
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            const url = 'mailto:lokaarpans@gmail.com';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text("lokaarpans@gmail.com",
                              style: Theme.of(context).textTheme.bodyText2)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        'Check out our blog: https://lokaarpan.com');
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/share.png",
                      width: 30,
                    ),
                    title: Text('Share'),
                    subtitle: Text("Spread the words of lokaarpan",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/notification.png",
                    width: 30,
                  ),
                  isThreeLine: true,
                  title: Text('Notification'),
                  subtitle: Text("Change notification preference",
                      style: Theme.of(context).textTheme.bodyText2),
                  trailing: Switch(
                      onChanged: (val) async {
                        await enableNotification(context, val);
                      },
                      activeColor: Theme.of(context).accentColor,
                      value: Provider.of<AppStateNotifier>(context)
                          .notificationOn),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/lamp.png",
                    width: 30,
                  ),
                  isThreeLine: true,
                  title: Text('Dark Theme'),
                  subtitle: Text("Join the Dark Side",
                      style: Theme.of(context).textTheme.bodyText2),
                  trailing: Switch(
                    onChanged: (val) async {
                      await changeToDarkTheme(context, val);
                    },
                    activeColor: Theme.of(context).accentColor,
                    value: Provider.of<AppStateNotifier>(context).isDarkMode,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
