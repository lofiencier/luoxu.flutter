import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  String title;
  Widget child;
  Layout({this.child, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == 'Searching'
          ? null
          : new AppBar(
              title: new Text(title ?? 'default title'),
            ),
      body: child,
      floatingActionButton: title != 'Searching'
          ? FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed('/searching'),
            )
          : FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pushNamed('/'),
            ),
    );
  }
}
