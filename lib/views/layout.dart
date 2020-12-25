import 'package:flutter/material.dart';
import 'package:lecture/main.dart';
import 'package:provider/provider.dart';
import 'trial.dart' show Trial;
import 'favorite.dart' show Favorite;
import '../models/index.dart' as models;

class Layout extends StatelessWidget {
  String title;
  Widget child;
  bool hasTab = false;
  Layout({this.child, this.title, this.hasTab, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(
          builder: (BuildContext _context) {
            final TabController tabController =
                DefaultTabController.of(_context);
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                Provider.of<models.Playing>(context, listen: false)
                    .onTabChange(context, tabController.index);
              }
            });
            return Scaffold(
              appBar: title != 'Favorite'
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
                                    text: 'Favorite',
                                    icon: Icon(Icons.favorite))
                              ],
                            )
                          : null,
                    ),
              body: hasTab
                  ? new TabBarView(children: [
                      Trial(),
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
            );
          },
        ));
  }
}
