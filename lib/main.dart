import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'service/index.dart' as Api;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
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

class Layout extends StatelessWidget {
  String title;
  Widget child;
  Layout({Widget this.child, String this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(title ?? 'default title')),
      body: child,
    );
  }
}

class Playing extends StatelessWidget {
  const Playing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class Favorite extends StatelessWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Playlist(
        data: new List<Map>.filled(20, {'title': '1', 'subTitle': '2'}));
  }
}

class Searching extends StatelessWidget {
  const Searching({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({this.data});
  final List data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: data
            .map(
              (item) => Column(
                children: [
                  ListTile(
                    title: Text('${item['title']}'),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    subtitle: Text('${item['subTitle']}'),
                    // tileColor: Colors.blue,
                    leading: Container(
                      child: ClipOval(
                        child: Image.network(
                          'https://t11.baidu.com/it/u1=4079196055&u2=1342350016&fm=76',
                          fit: BoxFit.cover,
                          color: Colors.black12,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    trailing: Icon(Icons.add),
                    // ?这里怎么显示两个icon？
                  ),
                  Divider(
                    height: 0,
                    indent: 20,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
