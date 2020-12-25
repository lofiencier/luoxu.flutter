import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart' as models;

class Searching extends StatelessWidget {
  const Searching({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<models.Searching>(builder: (_, _store, child) {
      return Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          color: Colors.blue,
          child: Column(
            children: [
              Card(
                child: TextField(
                  maxLines: 1,
                  onChanged: _store.setQuery,
                  onSubmitted: _store.onSubmit,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: 'JACKPOT!!'),
                ),
              ),
              _store.searchList.isNotEmpty
                  ? Expanded(
                      child: Card(
                        child: ListView(
                          children: _store.searchList
                              .map((item) => ListTile(
                                    title: Text(item['name']),
                                    subtitle: Text(item['artist']),
                                    onTap: () => context
                                        .read<models.Playing>()
                                        .addSongToList(item, context, true),
                                  ))
                              .toList(),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ));
    });
  }
}
