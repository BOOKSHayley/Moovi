import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/Theme/MooviProgressIndicator.dart';
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/main.dart';
import 'package:moovi/movie/Movie.dart';
import 'package:moovi/movie/MovieCardStack.dart';
import 'Movie.dart';
import 'MovieCard.dart';


class Queue extends StatefulWidget {
  final db;
  const Queue(this.db, {Key? key}) : super(key: key);

  @override
  QueueState createState() => QueueState(db);
}

class QueueState extends State<Queue> with SingleTickerProviderStateMixin {
  final db;

  final user = LoginPage.user;
  final stackKey = GlobalKey<MovieCardStackState>();

  late MainViewModel mvm;
  QueueState(this.db){
    mvm = new MainViewModel(db);
  }
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    List<MovieCard> cardsList;
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder<List<MovieEntity?>>(
        stream: mvm.getMoviesInPersonalQueueAsStream(user, MenusStatefulWidget.genres),
        builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
          if(snapshot.hasError) { print("ERROR!"); }
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return MooviProgressIndicator();
            case ConnectionState.done:
              if(snapshot.hasData){
                cardsList = generateCardsList(snapshot.data!.take(10).toList());
              }
              else{
                cardsList = [new MovieCard(user.userName, new MovieEntity(null, "Error", "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg", "mpaa", 10, "runtime", "genres", 0000, "None", "synopsis"))];
              }
              return MovieCardStack(cardsList);
          }
        }
      ),
    );
  }

  stackSwipe(bool leftSwipe){
    stackKey.currentState?.popMovieCard().autoSwipe(leftSwipe);
    stackKey.currentState?.stackRefresh();
  }

  //only generates 20 cards
  generateCardsList(List<MovieEntity?> movieEntities){
    List<MovieCard> cardList = [];
    for(int i = 0; i < 10; i++){
      if(movieEntities[i] == null){
        continue;
      }
      cardList.add(new MovieCard(user.userName, movieEntities[i]!));
    }
    return cardList;
  }

}

