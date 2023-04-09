import 'package:flutter/material.dart';
import '/models/joke.dart';

import '../logic/fb_service.dart';
import '../logic/load_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  String textHolder = 'Click a button to see a random Chuck Norris Joke';
  var category = "random";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Chuck Norris App')),
        persistentFooterButtons: <Widget>[
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pushNamed("/favourites"),
            icon: const Icon(Icons.favorite),
            label: const Text('Go to favourites'),
          )
        ],
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SizedBox(
                height: 135.0,
                child : SingleChildScrollView(
                  child: Text(textHolder, style: const TextStyle(fontSize: 20)),
                ),
              )),
          ElevatedButton(
            onPressed: () async {
              Joke jokeObjectR = await LoadData.getData(category);
              setState(() { textHolder = jokeObjectR.text; });
            },
            child: const Text('Switch joke'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(padding: const EdgeInsets.all(10.0)),
            onPressed: () => AddDataService.add_favourite(textHolder),
            child: const Text('Add to favourites'),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text('Current category:''$category', style: const TextStyle(fontSize: 17)),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text('Search by category:', style: TextStyle(fontSize: 17)),
          ),
          ElevatedButton(onPressed: () {setState(() {category = "random";});},child: Text("random")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "animal";});},child: Text("animal")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "career";});},child: Text("career")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "celebrity";});},child: Text("celebrity")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "dev";});},child: Text("dev")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "explicit";});},child: Text("explicit")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "fashion";});},child: Text("fashion")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "food";});},child: Text("food")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "history";});},child: Text("history")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "amoneyll";});},child: Text("money")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "movie";});},child: Text("movie")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "music";});},child: Text("music")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "political";});},child: Text("political")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "religion";});},child: Text("religion")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "science";});},child: Text("science")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "sport";});},child: Text("sport")),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {setState(() {category = "travel";});},child: Text("travel")),
          const SizedBox(height: 10,),
        ]))
        ));
  }
}
