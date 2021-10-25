
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class LikedListMenu{
  Widget returnMyList(){
    Widget myMovies =  //List of widgets for the screen
      ListView(
        children: const <Widget>[
          Card(child: ListTile(title: Text('No One Gets Out Alive'))),
          Card(child: ListTile(title: Text('The Starling'))),
          Card(child: ListTile(title: Text('My Little Pony'))),
          Card(child: ListTile(title: Text('Venom'))),
          Card(child: ListTile(title: Text('The Guilty')))]);
    return myMovies;
  }
}