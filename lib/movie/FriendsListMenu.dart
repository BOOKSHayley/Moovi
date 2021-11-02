import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/database/friendsEntity.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/movie/friendsMatchedMoviesFriend1.dart';
import 'package:moovi/movie/friendsMatchedMoviesFriend2.dart';

import 'FriendMatchedCard.dart';

class FriendsListMenu extends StatelessWidget{

  late final db;
  late final MainViewModel mvm;
  FriendsListMenu(this.db){
    mvm = MainViewModel(db);
  }

  @override
  Widget build(BuildContext context){
    List<InkWell> cards = [];
    return Scaffold(
    body: Center(child:
    ListView(
        children: <Widget>[
          Container(
              child: StreamBuilder<List<UserEntity?>>(
                  stream: mvm.getAllFriendsOfUserAsStream("H1", false),
                  builder: (BuildContext context, AsyncSnapshot<List<UserEntity?>> snapshot){
                    if(snapshot.hasData){
                      cards = buildFriendCards(snapshot.data!, context);
                    } else{
                      cards =
                    [InkWell(
                    child: Container(
                    child: Card(
                    color: Colors.lightBlue, child: ListTile(title: Text("No friends yet", style: TextStyle(
                    color: Colors.white))))))];
                    }
                    return Stack(
                      children: cards,
                    );
                  }
              )
          )
        ]
    ),
    ));
  }

  List<InkWell> buildFriendCards(List<UserEntity?> friends, BuildContext context) {
    List<InkWell> cards = [];

    for(int i = 0; i < friends.length; i++) {
        InkWell(
            child: Container(
            child: Card(
            color: Colors.lightBlue, child: ListTile(title: Text(friends[i]!.name, style: TextStyle(
            color: Colors.white))))),
      onTap:(){
      Navigator.of(context)
          .push(
      MaterialPageRoute(builder: (context) => FriendMatchedCard(friends[i]!.userName, friends[i]!.name, mvm))
      );
      });
    }

    return cards;
  }
}