import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/Theme/MooviCowProfile.dart';
import 'package:moovi/database/userEntity.dart';
import '../Theme/MooviProgressIndicator.dart';
import '../main.dart';
import 'FriendProfile.dart';
import 'package:moovi/friends/pendingFriendsList.dart';

class FriendsListMenu extends StatefulWidget {
  static List<int> numSharedMovies = [];
  const FriendsListMenu({Key? key}) : super(key: key);

  _FriendsListMenu createState() => _FriendsListMenu();
}

class _FriendsListMenu extends State<FriendsListMenu> {

  @override
  Widget build(BuildContext context) {
    List<InkWell> cards = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List', style: TextStyle(fontSize: 26),),
      ),
      body: Column(
      children: [
        StreamBuilder<List<UserEntity?>>(
          stream: MyApp.mvm.getAllFriendsOfUserAsStream(MyApp.user, false),
          builder: (BuildContext context,
              AsyncSnapshot<List<UserEntity?>> snapshot) {
            if(snapshot.hasError) { print("ERROR!"); }
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return MooviProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  cards = buildFriendCards(snapshot.data!, context);
                } else {
                  cards = [ noFriends() ];
                }
                return Expanded(
                    child: ListView(children: cards)
                );
            }
          })]),
          floatingActionButton: Stack(
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(builder: (context) => PendingFriendsList())

                  );
                },
                child: Icon(Icons.person_add),
                backgroundColor: Colors.yellow,
              ),
              Visibility(
                visible: PendingFriendsList.numPending != 0,
                child: Positioned(
                  top: 0,
                  left: 35,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.red,
                    child: Text(PendingFriendsList.numPending.toString(), style: TextStyle(color: Colors.white, fontSize: 15),),
                  )
                )
              ),
            ],
          )
    );
  }

  List<InkWell> buildFriendCards(List<UserEntity?> friends, BuildContext context){
    List<InkWell> cards = [];

    if(friends.length != FriendsListMenu.numSharedMovies.length){
      FriendsListMenu.numSharedMovies.fillRange(0, FriendsListMenu.numSharedMovies.length, 0);
      print("Error getting shared movie number");
    }

    if(friends.length == 0){
      cards = [ noFriends() ];
    } else {
      for (int i = 0; i < friends.length; i++) {
        cards.add(InkWell(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: MooviCowProfile()
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              friends[i]!.userName,
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(FriendsListMenu.numSharedMovies[i].toString(), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Text("Shared Movies", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    FavoriteButton(
                      valueChanged: (_isFave){ },
                    )
                  ],
                )
              ]),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FriendMatchedCard(
                  friends[i]!, FriendsListMenu.numSharedMovies[i])));
            }));
      }
    }

    return cards;
  }

  InkWell noFriends(){
    return InkWell(
      child: Container(
        child: Card(
          child: ListTile(
            title: Text("No friends added. Click on the button in the corner to add some!",
              style: TextStyle(fontSize: 22))))));
  }
}



