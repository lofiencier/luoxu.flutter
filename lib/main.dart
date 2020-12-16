import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'service/index.dart' as Api;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  void getData() async {
    var url = Api.search('周杰伦');
    print(url);
    try {
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '123121',
      home: Scaffold(
        appBar: null,
        body: RaisedButton(
          onPressed: getData,
          child: Text('123123'),
        ),
      ),
    );
  }
}
