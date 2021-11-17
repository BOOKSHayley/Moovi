import 'dart:ui';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/userEntity.dart';
import '../Theme/MooviProgressIndicator.dart';
import 'FriendProfile.dart';
import 'package:moovi/friends/pendingFriendsList.dart';

class FriendsListMenu extends StatefulWidget {
  static List<int> numSharedMovies = [];
  final db;
  const FriendsListMenu(this.db, {Key? key}) : super(key: key);

  _FriendsListMenu createState() => _FriendsListMenu(db);
}

class _FriendsListMenu extends State<FriendsListMenu> {
  late MainViewModel mvm;
  final db;
  _FriendsListMenu(this.db){
    mvm = MainViewModel(db);
  }


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
            stream: mvm.getAllFriendsOfUserAsStream(LoginPage.user, false),
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
            floatingActionButton: FloatingActionButton(
                    onPressed: () {
                        Navigator.of(context)
                        .push(
                            MaterialPageRoute(builder: (context) => PendingFriendsList(db))
                        );
                    },
                    child: const Icon(Icons.person_add),
                    backgroundColor: Colors.yellow,)
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
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    radius: 22,
                                    child:Image.asset("assets/MooviCow.png")
                                ),
                              )
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

                      // Padding(
                      //     padding: EdgeInsets.only(left: 150),
                      //     child:
                      // )



                    ]),

            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      FriendMatchedCard(
                          friends[i]!.userName, friends[i]!.name, mvm)));
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



