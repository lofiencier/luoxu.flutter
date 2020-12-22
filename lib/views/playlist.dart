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
                    title: Text('${item['name']}'),
                    focusColor: Colors.red,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    subtitle: Text('${item['artist']}'),
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
                    trailing: Icon(Icons.add),
                    // ?这里怎么显示两个icon？
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
