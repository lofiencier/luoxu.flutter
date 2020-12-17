import 'package:flutter/material.dart';

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
