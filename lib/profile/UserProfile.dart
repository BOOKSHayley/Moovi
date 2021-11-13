import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/DatabaseGetter.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/movie/Movie.dart';
import '../movie/Movie.dart';
import '../movie/MovieCard.dart';


class LikedList extends StatefulWidget {
  final db;
  const LikedList(this.db, {Key? key}) : super(key: key);

  @override
  _LikedList createState() => _LikedList(db);
}

class _LikedList extends State<LikedList> {
  final db;
  final username = LoginPage.username;
  late MainViewModel mvm;
  _LikedList(this.db){
    mvm = new MainViewModel(db);
  }

  late Stream<List<MovieEntity?>> stream;
  @override
  void initState() {
    super.initState();
    stream =  mvm.getLikedMoviesOfUserAsStream(username);
  }

  @override
  Widget build(BuildContext context) {
    var username = LoginPage.username;
    var userEntitiy = mvm.getUserbyUsername(username);
    var name;
    List<Card> cardsList;
    return Container(
      width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<MovieEntity?>>(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
            if(snapshot.hasError) { print("ERROR!"); }
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.done:
                if(snapshot.hasData){
                  cardsList = generateCardsList(snapshot.data!);
                }
                else{
                  cardsList = [
                    new Card(child: ListTile(title: Text("No liked movies yet. Go back to the Queue and Like some!")))
                  ];
                }
                return UserProfile(db, mvm, username, cardsList);
            }

          }
      ),
    );
  }


  generateCardsList(List<MovieEntity?> movieEntities){
    List<Card> cardList = [];
    for(int i = 0; i < movieEntities.length; i++){
      if(movieEntities[i] == null){
        continue;
      }
      cardList.add(new Card(child: ListTile(title: Text(movieEntities[i]!.title))));
    }
    return cardList;
  }

}

class UserProfile extends StatelessWidget{
  final username;
  final cardList;
  final db;
  final mvm;
  const UserProfile(this.db, this.mvm, this.username, this.cardList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.deepPurple,
                      Colors.deepPurpleAccent
                    ],
                  )
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    username,
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
                              child: Text("Logout"),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text("Edit Profile"),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text("Settings"),
                              value: 3,
                            )
                          ],

                          onSelected: (result) {
                            if (result == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage(db, mvm)),
                              );
                            } else if (result == 2){
                              //todo: create an 'edit profile' page and use navigator
                            } else{
                              //todo: create a settings page and use navigator
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
                  'Your liked moves',
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

class Settings extends StatelessWidget{
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(

    );

  }


}

