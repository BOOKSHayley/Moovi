import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/movie/friendsMatchedMoviesFriend1.dart';
import 'package:moovi/movie/friendsMatchedMoviesFriend2.dart';

class FriendsListMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    body: Center(child: 
    ListView( children: <Widget>[
        InkWell(child: Container(child: Card(color: Colors.lightBlue, child: ListTile(title: Text('Hayley Roberts', style: TextStyle(
    color: Colors.white)
    )))),
        onTap:(){
          Navigator.of(context)
                .push(
                     MaterialPageRoute(builder: (context) => friendsMatchedMoviesFriend1())
                );
          //print("Hayley Clicked");
        },),
        InkWell(child: Container(child: Card(color: Colors.deepPurple, child: ListTile(title: Text('Karley Waguespack', style: TextStyle(
    color: Colors.white))
    ))),
        onTap:(){
           Navigator.of(context)
                .push(
                     MaterialPageRoute(builder: (context) => friendsMatchedMoviesFriend2())
                );
          //friendsMatchedMovies();
          print("Karley Clicked");
        },),
        InkWell(child: Container(child: Card(child: ListTile(title: Text('Lucas Colegrove')))),
        onTap:(){
          //friendsMatchedMovies();
          print("Lucas Clicked");
        },)
    ]
    
    ),
    ));
  }

  Widget returnFriendsList(){
    Widget friendMovies =  //List of widgets for the screen
      ListView( children: const <Widget>[
        Card(child: ListTile(title: Text('The Guilty'))),
        Card(child: ListTile(title: Text('The Starling Darling'))),
        Card(child: ListTile(title: Text('Venom')))]);
    return friendMovies;
  }
}