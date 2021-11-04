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


class Queue extends StatefulWidget {
  final db;
  const Queue(this.db, {Key? key}) : super(key: key);

  @override
  _QueueState createState() => _QueueState(db);
}

class _QueueState extends State<Queue> with SingleTickerProviderStateMixin {
  final db;
  final username = "H1";
  late MainViewModel mvm;
  _QueueState(this.db){
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
                  print(snapshot.connectionState);
                  cardsList = generateCardsList(snapshot.data!);
                }
                else{
                  cardsList = [new MovieCard(username, new MovieEntity(null, "Error", "https://lh3.googleusercontent.com/proxy/kBoNolp24hAlmENDXwRtq2ZvzWBNOS3Dhn1nCBibdbf3PoqYsCHyWbGMBW_kOTV2Rf9mC04m0D6eIUSddob6rP3mWwTl9OSS1M3uxR-yOwvPYdWm2okztGxnD_XueHu1Ap9MYqhnwTkFztBQ", "mpaa", 10, "runtime", "genres", "synopsis"))];
                }
                return Stack(
                  children: cardsList,
                );
              }
            ),
    );
  }

  updateCardsList(){
    //add the next 10 movies to the back of the list
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

