import 'package:json_annotation/json_annotation.dart';
part 'joke.g.dart';

@JsonSerializable()
class Joke {
  String text = "Some text";

  Joke({this.text = "Some text"});

  factory Joke.fromJson(Map<String, dynamic> data) => _$JokeFromJson(data);

  Map<String, dynamic> toJson() => _$JokeToJson(this);
}
