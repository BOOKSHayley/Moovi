import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
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
  final username = "H1";
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
              stream: mvm.getMoviesInPersonalQueueAsStream("H1"),
              builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
                if(snapshot.hasData){
                  cardsList = generateCardsList(snapshot.data!);
                }
                else{
                  cardsList = [new MovieCard(username, new MovieEntity(null, "Error", "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg", "mpaa", 10, "runtime", "genres", 0000, "None", "synopsis"))];
                }
                return MovieCardStack(cardsList);
              }
            ),
    );
  }

  stackSwipe(bool leftSwipe){
    stackKey.currentState!.popMovieCard().autoSwipe(leftSwipe);
    stackKey.currentState!.stackRefresh();
  }

  generateCardsList(List<MovieEntity?> movieEntities){
    List<MovieCard> cardList = [];
    for(int i = 0; i < movieEntities.length; i++){
        if(movieEntities[i] == null){
          continue;
        }
        cardList.add(new MovieCard(username, movieEntities[i]!));
    }
    return cardList;
  }

}

