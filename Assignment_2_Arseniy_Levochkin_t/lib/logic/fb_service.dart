import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

class AddDataService{

  static load_jokes(_connectivityResult) async {
    _connectivityResult = await check_internet();
    if(_connectivityResult){
      List<String> jokesD = await _get_firestore_data();
      return jokesD;
    }else{
      List<String> jokesD = await _read();
      return jokesD;
    }
  }

  static add_favourite(jokeText) async {
    _write(jokeText);
    List list = await _read();
    var stringList = list.join(" -NEXT- ");
    FirebaseFirestore.instance.collection('jokes').add({'text': jokeText});
  }

  static _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/jokes_storage.txt');
    file.writeAsStringSync(text+"\n", mode: FileMode.append);
  }

  static _read() async {
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

  static Future<bool> check_internet() async {
    var _connectivityResult_g = await InternetConnectionChecker().hasConnection;
    return Future<bool>.value(_connectivityResult_g);
  }

  static _get_firestore_data() async {
    List<String> text = [];
    
    final data = await FirebaseFirestore.instance.collection("jokes").get();

    data.docs.forEach((element) {
    final mapStr = element.data();
    text.add(mapStr['text']);
    });

    return text;
  }

}