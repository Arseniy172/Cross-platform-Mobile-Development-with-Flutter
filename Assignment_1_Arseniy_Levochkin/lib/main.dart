import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'joke.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('CPMDWithF Assignment 1')),
            body: Center(child: SwitchJoke())));
  }
}

class SwitchJoke extends StatefulWidget {
  @override
  _SwitchJokeState createState() => _SwitchJokeState();
}

class _SwitchJokeState extends State {
  String textHolder = 'Click a button to see a random Chuck Norris Joke';

  Joke jokeObject = new Joke(text: "some text from object");

  getData() async {
    print("REQUEST GET");
    var dio = Dio();
    var res = await dio.get("https://api.chucknorris.io/jokes/random",
        options: Options(
          responseType: ResponseType.plain,
        ));
    if (res.statusCode == 200) {
      var data = json.decode(res.data);
      print("text out:" + data['value']);
      Joke tmp_jokeObject = new Joke(text: data['value']);
      print("text out from object:" + tmp_jokeObject.text);
      return tmp_jokeObject;
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(20.0),
      ),
      Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text('$textHolder', style: TextStyle(fontSize: 21))),
      // ),
      ElevatedButton(
        onPressed: () async {
          Joke joke_object_r = await getData();
          print("joke_object_r.text->" + joke_object_r.text);
          setState(() {
            textHolder = joke_object_r.text;
          });
        },
        child: Text('Switching joke'),
      )
    ])));
  }
}
