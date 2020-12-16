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
  Layout({this.child, this.title });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == 'Searching' ? null : new AppBar(
        title: new Text(title ?? 'default title'),
      ),
      body: child,
      floatingActionButton: title != 'Searching' ? FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => Navigator.of(context).pushNamed('/searching'),
      ): FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pushNamed('/'),
      ),
    );
  }
}

class Playing extends StatelessWidget {
  const Playing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
              child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(40),
                color: Colors.black,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=355294600,364125621&fm=26&gp=0.jpg'),
                  backgroundColor: Colors.brown.shade800,
                  radius: 120,
                  child: Icon(Icons.play_circle_filled, size: 70, color: Colors.white,),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            ),
            Container(margin: EdgeInsets.only(top: 30),),
            Text('Imagine Dragons', style: TextStyle(fontSize: 20),),
            Text('Radioactive', style: TextStyle(color: Colors.grey),),
            Text('10/21', style: TextStyle(color: Colors.grey)),
            ControlBar()
          ],
        ),
      ),
    );
  }
}
class ControlBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding:const EdgeInsets.fromLTRB(40,40,40,80), 
      child: Column(
        children: <Widget>[
            LinearProgressIndicator(
              value: .1,
              valueColor: AlwaysStoppedAnimation(Colors.red),
              backgroundColor: Colors.grey,
            ),
            ControlBarButtons(),
        ],
      ),
    );
  }
}
class ControlBarButtons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.shuffle),
        Icon(Icons.fast_rewind),
        Icon(Icons.play_circle_filled, size: 50, color: Colors.red,),
        Icon(Icons.fast_forward),
        Icon(Icons.file_download)
      ],
    ),
    );
  }
}
class Favorite extends StatelessWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Playlist(data: new List<Map>.filled(20, {'title': '1', 'subTitle': '2'}));
  }
}

class Searching extends StatelessWidget {
  const Searching({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      color: Colors.blue,
      child: Column(
        children: [
          Card(
            child: TextField(
              maxLines: 1,
              decoration:InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10),
                hintText: 'JACKPOT!!'
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: ListView(
                children: new List<int>.filled(20, 1).map((item) => ListTile(title: Text('1'),)).toList(),
              ),
            ),
          ),
        ],
      )
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
                    focusColor: Colors.red,
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
                    onTap: () => Navigator.of(context).pushNamed('/playing'),
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
