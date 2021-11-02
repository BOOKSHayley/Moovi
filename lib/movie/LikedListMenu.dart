
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';

class LikedListMenu{
  late final db;
  late MainViewModel mvm;
  LikedListMenu(this.db){
    mvm = MainViewModel(db);
  }

  Widget returnMyList(){
    List<Card> cards;
    return Container(
        child: StreamBuilder<List<MovieEntity?>>(
            stream: mvm.getLikedMoviesOfUserAsStream("H1"),
            builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
              if(snapshot.hasData){
                cards = buildCards(snapshot.data!);
              } else{
                cards = [Card(child: ListTile(title: Text("No Liked Movies yet!"),),)];
              }
              return ListView(
                children: cards,
              );
            }
        )
    );
  }

  List<Card> buildCards(List<MovieEntity?> movieEntities){
    List<Card> likedMovies = [];
    for(int i = 0; i < movieEntities.length; i++){
      if(movieEntities[i] == null){
        continue;
      }
      print(movieEntities[i]!.title);
      likedMovies.add(new Card(child: ListTile(title: Text(movieEntities[i]!.title))));
    }
    return likedMovies;
  }
}