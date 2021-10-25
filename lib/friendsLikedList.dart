import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class friendsLikedList{
    
     Widget returnFriendsList(){
       Widget friendMovies =  //List of widgets for the screen
          ListView( children: const <Widget>[
          Card(child: ListTile(title: Text('The Guilty'))),
          Card(child: ListTile(title: Text('The Starling Darling'))),
          Card(child: ListTile(title: Text('Venom')))]);
       return friendMovies;
     }

}