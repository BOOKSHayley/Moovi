import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/movie/Movie.dart';
import 'Movie.dart';
import 'MovieCard.dart';


class LikedList extends StatefulWidget {
  final db;
  const LikedList(this.db, {Key? key}) : super(key: key);

  @override
  _LikedList createState() => _LikedList(db);
}

class _LikedList extends State<LikedList> {
  final db;
  final username = "H1";
  late MainViewModel mvm;
  _LikedList(this.db){
    mvm = new MainViewModel(db);
  }
  late Stream<List<MovieEntity?>> stream;
  @override
  void initState() {
    super.initState();
    stream =  mvm.getLikedMoviesOfUserAsStream(username);
  }

  @override
  void dispose(){
    super.dispose();
  }

  //HEY KARLEY!!!
  //So I know what the issue is but I have no clue how to fix it.
  //The connectionState is never finishing and reaching a done state.
  //instead its staying in the waiting state forever even though I know it should have something
  //If you run it you'll see its waiting and the movie titles being printed
  //Any help is appreciated. Thank you !! <3
  @override
  Widget build(BuildContext context) {
    List<Card> cardsList;
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder<List<MovieEntity?>>(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
            if(snapshot.hasError) { print("ERROR!"); }
            switch(snapshot.connectionState){
              case ConnectionState.none:
                print("Connection state of LikedMovies is None");
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.waiting:
                print("Connection state of LikedMovies is Waiting");
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.active:
                print("Connection state of LikedMovies is Active");
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.done:
                print("Connection state of LikedMovies is Done");
                if(snapshot.hasData){
                  print("Has data");
                  cardsList = generateCardsList(snapshot.data!);
                }
                else{
                  print("No data");
                  cardsList = [
                    new Card(child: ListTile(title: Text("No movies")))
                  ];
                }
                return ListView(
                  children: cardsList,
                );
            }

          }
      ),
    );
  }

  updateCardsList(){
    //add the next 10 movies to the back of the list
  }

  generateCardsList(List<MovieEntity?> movieEntities){
    List<Card> cardList = [];
    for(int i = 0; i < movieEntities.length; i++){
      if(movieEntities[i] == null){
        continue;
      }
      cardList.add(new Card(child: ListTile(title: Text(movieEntities[i]!.title))));
    }
    return cardList;
  }

}

