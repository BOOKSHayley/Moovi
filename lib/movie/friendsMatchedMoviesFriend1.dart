
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class friendsMatchedMoviesFriend1 extends StatelessWidget{
  List<Widget> matchedMovies = <Widget>[]; //empty list of matched movies; gets filled based on the friend clicked

  @override
  Widget build(BuildContext context){
    convertMatchedMoviesToCardsFriend1();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_left_rounded),
            tooltip: 'Go Back to Friends List',
            onPressed: (){
              Navigator.pop(context);
            },),
        title: Text('Hayley Roberts'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(child: ListView(children: matchedMovies),      
      ),  
    
    );
  }

  void convertMatchedMoviesToCardsFriend1(){
    matchedMovies.add(Card(child: ListTile(title: Text('The Guilty'))));
    matchedMovies.add(Card(child: ListTile(title: Text('Venom'))));
    matchedMovies.add(Card(child: ListTile(title: Text('Gunpowder Milkshake'))));
  }

 
}