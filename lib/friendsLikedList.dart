import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class friendsLikedList{

    Widget returnFriendsList(){
      Widget friendsList = ListView(children: <Widget>[
        GestureDetector(
          onTap:(){
              print('hello');
          },
          child: Card(child: ListTile(title: Text('Friend1'))),
        ),
        GestureDetector(
          onTap:(){
              //returnFriend2LikedMoviesList();
               ListView( children: <Widget>[
                  Card(child: ListTile(title: Text('The Guilty'))),
                  Card(child: ListTile(title: Text('The Starling Darling'))),
                  Card(child: ListTile(title: Text('Venom')))]);
            },
          child: Card(child: ListTile(title: Text('Friend2'))),
        ),
      ],);
      return friendsList;
    }
    
     Widget returnFriend1LikedMoviesList(){
       Widget friendMovies =  //List of widgets for the screen
          ListView( children: <Widget>[
          Card(child: ListTile(title: Text('The Guilty'))),
          Card(child: ListTile(title: Text('The Starling Darling'))),
          Card(child: ListTile(title: Text('Venom')))]);
       return friendMovies;
     }

     Widget returnFriend2LikedMoviesList(){
       Widget friendMovies =  //List of widgets for the screen
          ListView( children: <Widget>[
          Card(child: ListTile(title: Text('The Shining'))),
          Card(child: ListTile(title: Text('The Voice Series'))),
          Card(child: ListTile(title: Text('CatWoman')))]);
       return friendMovies;
     }

}