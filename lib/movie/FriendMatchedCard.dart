
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';

class FriendMatchedCard extends StatelessWidget{
  final List<Widget> matchedMovies = <Widget>[];

  final friendUsername;
  final friendName;
  late final MainViewModel mvm;
  FriendMatchedCard(this.friendUsername, this.friendName, this.mvm);

  @override
  Widget build(BuildContext context){
    List<Card> cards = [];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_left_rounded),
          tooltip: 'Go Back to Friends List',
          onPressed: (){
            Navigator.pop(context);
          },),
        title: Text(friendUsername + " (" + friendName + ")"),
        backgroundColor: Colors.lightBlue,
        ),
        body: Center(
          child: ListView(children: <Widget>[
            Container(
                child: StreamBuilder<List<MovieEntity?>>(
                    stream: mvm.getSharedLikedMoviesAsStream("H1", friendUsername),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MovieEntity?>> snapshot) {
                      if (snapshot.hasData) {
                        cards = buildMatchedMovieCards(snapshot.data!);
                      } else {
                        cards = [Card(child: ListTile(title: Text("No shared movies yet.")))];
                      }
                      return Stack(
                        children: cards,
                      );
                    }))
          ]),
        ));
  }

  List<Card> buildMatchedMovieCards(List<MovieEntity?> movies){
      List<Card> cards = [];
      for(int i = 0; i < movies.length; i++){
          cards.add(Card(child: ListTile(title: Text(movies[i]!.title))));
      }
      return cards;
  }


}