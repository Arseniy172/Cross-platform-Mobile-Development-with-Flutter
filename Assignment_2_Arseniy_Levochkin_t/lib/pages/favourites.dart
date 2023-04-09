import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async'; 

Future<List<String>> _read() async {
  List<String> text = [];
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jokes_storage.txt');
    text = await file.readAsLines();
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}

Future<List<String>> _get_firestore_data() async {
  List<String> text = [];
  
  final data = await FirebaseFirestore.instance.collection("jokes").get();

  data.docs.forEach((element) {
   final mapStr = element.data();
   text.add(mapStr['text']);
  });

  return text;
}

class FavouritesPageS extends StatefulWidget {
  const FavouritesPageS({super.key});

  @override
  State<StatefulWidget> createState() => FavouritesPageState();
}

class FavouritesPageState extends State<FavouritesPageS> {
  List<String> _jokes_data = [];
  var _connectivityResult = false;

  Future<bool> check_internet() async {
    var _connectivityResult_g = await InternetConnectionChecker().hasConnection;
    return Future<bool>.value(_connectivityResult_g);
  }

  @override
  void initState() {
    _load_jokes();
    super.initState();
  }

  _load_jokes() async {
    _connectivityResult = await check_internet();
    if(_connectivityResult){
      List<String> jokesD = await _get_firestore_data();
      setState(() {
        _jokes_data = jokesD;
      });
    }else{
      List<String> jokesD = await _read();
      setState(() {
        _jokes_data = jokesD;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: ListView.builder(
            itemCount: _jokes_data.length,
            itemBuilder: (context, index) {
              return Text(_jokes_data[index]+"\n", style: const TextStyle(fontSize: 20));
            },
          ),
        ),
      ),
    );
  }
}

