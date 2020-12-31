import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/index.dart' as models;

class Playlist extends StatelessWidget {
  Set data;
  Playlist({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView(
          children: data.map(
            (item) {
              final isActive = item == context.watch<models.Playing>().songInfo;
              return Column(
                children: [
                  ListTile(
                    title: Text('${item['artist']}'),
                    focusColor: Colors.red,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    subtitle: Text('${item['name']}'),
                    tileColor: isActive ? Colors.blue[50] : null,
                    // 403 不给用是嘛
                    // leading: Container(
                    //   child: ClipOval(
                    //     child: Image.network(
                    //       item['pic'],
                    //       fit: BoxFit.cover,
                    //       color: Colors.black12,
                    //       width: 50,
                    //       height: 50,
                    //     ),
                    //   ),
                    // ),
                    onTap: () => context
                        .read<models.Playing>()
                        .playSong(item, context, true),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete_outline), onPressed: null),
                        IconButton(
                          icon: Icon(Icons.favorite_outline),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    indent: 20,
                  )
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
