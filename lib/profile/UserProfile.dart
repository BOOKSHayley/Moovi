import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/movie/Movie.dart';
import '../movie/Movie.dart';
import '../movie/MovieCard.dart';


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
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.done:
                if(snapshot.hasData){
                  cardsList = generateCardsList(snapshot.data!);
                }
                else{
                  cardsList = [
                    new Card(child: ListTile(title: Text("No liked movies yet. Go back to the Queue and Like some!")))
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

