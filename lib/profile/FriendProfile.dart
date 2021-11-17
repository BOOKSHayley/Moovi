
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';

import '../MooviProgressIndicator.dart';

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
      body: Center(
          child: Container(
              child: StreamBuilder<List<MovieEntity?>>(
                  stream: mvm.getSharedLikedMoviesAsStream(LoginPage.user, friendUsername),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MovieEntity?>> snapshot) {
                    if(snapshot.hasError) { print("ERROR!"); }
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return MooviProgressIndicator();
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          cards = buildMatchedMovieCards(snapshot.data!);
                        } else {
                          cards = [ noMovies() ];
                        }
                        return FriendProfile(mvm, widget.friendUsername, widget.friendName, cards);
                    }
                  }))
      ),
    );
  }

  List<Card> buildMatchedMovieCards(List<MovieEntity?> movies){
    List<Card> cards = [];
    if(movies.length == 0){
      cards = [ noMovies() ];
    } else {
      for (int i = 0; i < movies.length; i++) {
        cards.add(Card(child: ListTile(title: Text(movies[i]!.title, style: TextStyle(fontSize: 20)))));
      }
    }
    return cards;
  }

  Card noMovies(){
    return Card(child: ListTile(title: Text("No shared movies with " + friendName + " yet. :(", style: TextStyle(fontSize: 20),)));
  }


}

class FriendProfile extends StatelessWidget{
  final friendUsername;
  final name;
  final cardList;
  final MainViewModel mvm;
  const FriendProfile(this.mvm, this.friendUsername, this.name, this.cardList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 175,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[900]!, width: 5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff19194d),
                      Colors.deepPurple,
                    ],
                  )
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_left_rounded),
                          iconSize: 50,
                          tooltip: 'Go Back to Friends List',
                          onPressed: (){
                            Navigator.pop(context);
                          },),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.grey[900],
                                        radius: 25,
                                        child: Icon(
                                            Icons.person_rounded,
                                            size: 15,
                                            color: Colors.grey
                                        )
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text(
                                    name,
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "@" + friendUsername,
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                ),
                              ]
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Align(
                        alignment: Alignment.topRight,

                        child: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Remove Friend"),
                              value: 1,
                            )
                          ],

                          onSelected: (result) {
                            if (result == 1) {
                              mvm.removeFriendFromUser(LoginPage.user, friendUsername);
                              Navigator.pop(context);
                            }

                          },

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                          child: Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colors.white
                          ),
                        ),
                      ),
                    )

                  ]

              )
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    'Your shared movies',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              )
          ),
          Expanded(
              child: ListView(
                  children: cardList
              )
          ),
        ],
      ),
    );

  }


}