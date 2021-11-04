
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';

class FriendMatchedCard extends StatefulWidget {
  final friendUsername;
  final friendName;
  final MainViewModel mvm;

  const FriendMatchedCard(this.friendUsername, this.friendName, this.mvm, {Key? key}) : super(key: key);

  _FriendMatchedCard createState() => _FriendMatchedCard(friendUsername, friendName, mvm);
}

class _FriendMatchedCard extends State<FriendMatchedCard>{
  final friendUsername;
  final friendName;
  late final MainViewModel mvm;
  _FriendMatchedCard(this.friendUsername, this.friendName, this.mvm);

//ListView.builder

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
            child: Container(
                child: StreamBuilder<List<MovieEntity?>>(
                    stream: mvm.getSharedLikedMoviesAsStream("H1", friendUsername),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MovieEntity?>> snapshot) {
                      if (snapshot.hasData) {
                        cards = buildMatchedMovieCards(snapshot.data!);
                      } else {
                        cards = [Card(child: ListTile(title: Text("No shared movies yet.")))];
                      }
                      return ListView(
                        children: cards,
                      );
                    }))
          ),
    );
  }

  List<Card> buildMatchedMovieCards(List<MovieEntity?> movies){
      List<Card> cards = [];
      for(int i = 0; i < movies.length; i++){
          cards.add(Card(child: ListTile(title: Text(movies[i]!.title))));
      }
      return cards;
  }


}