import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/index.dart' as models;
import 'views/layout.dart' show Layout;
import 'views/favorite.dart' show Favorite;
import 'views/searching.dart' show Searching;
import 'views/playing.dart' show Playing;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => models.Searching()),
      ChangeNotifierProvider(create: (_) => models.Playlist()),
      ChangeNotifierProvider(create: (_) => models.Playing()),
    ],
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<models.Playing>(context, listen: false).initToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '大棉裤骑士',
      routes: {
        '/': (context) => Layout(child: Favorite(), title: 'Favorite'),
        '/searching': (context) => Layout(
              child: Searching(),
              title: 'Searching',
            ),
        '/playing': (context) => Layout(
              child: Playing(),
              title: 'Playing',
            ),
      },
    );
  }
}
