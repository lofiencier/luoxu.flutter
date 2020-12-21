import 'package:flutter/material.dart';
import 'package:lecture/main.dart';
import 'favorite.dart' show Favorite;

class Layout extends StatelessWidget {
  String title;
  Widget child;
  bool hasTab = false;
  Layout({this.child, this.title, this.hasTab});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: title == 'Searching'
              ? null
              : new AppBar(
                  toolbarHeight: 72,
                  title: hasTab
                      ? new TabBar(
                          isScrollable: true,
                          tabs: [
                            new Tab(
                              text: 'Trial',
                              icon: Icon(Icons.headset),
                            ),
                            new Tab(
                                text: 'Favorite', icon: Icon(Icons.favorite))
                          ],
                        )
                      : null,
                ),
          body: hasTab
              ? new TabBarView(children: [
                  Favorite(),
                  Favorite(),
                ])
              : child,
          floatingActionButton: title != 'Searching'
              ? FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/searching'),
                )
              : FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pushNamed('/'),
                ),
        ));
  }
}
