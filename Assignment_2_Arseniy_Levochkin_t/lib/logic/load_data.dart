import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/joke.dart';

class LoadData{

  static getData(category) async {
    var url = '';
    if(category == 'random'){
      url = "https://api.chucknorris.io/jokes/random";
    }else{
      url = "https://api.chucknorris.io/jokes/random?category="+category;
    }
    var dio = Dio();
    var res = await dio.get(url,
        options: Options(
          responseType: ResponseType.plain,
        ));
    if (res.statusCode == 200) {
      var data = json.decode(res.data);
      Joke tmpJokeobject = Joke(text: data['value']);
      return tmpJokeobject;
    } else {
      print("Error");
    }
  }

}