import 'package:flutter/material.dart';
import 'controlBar.dart' show ControlBar;

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
                    backgroundImage: NetworkImage(
                        'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=355294600,364125621&fm=26&gp=0.jpg'),
                    backgroundColor: Colors.brown.shade800,
                    radius: 120,
                    child: Icon(
                      Icons.play_circle_filled,
                      size: 70,
                      color: Colors.white,
                    ),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
            ),
            Text(
              'Imagine Dragons',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Radioactive',
              style: TextStyle(color: Colors.grey),
            ),
            Text('10/21', style: TextStyle(color: Colors.grey)),
            ControlBar()
          ],
        ),
      ),
    );
  }
}
