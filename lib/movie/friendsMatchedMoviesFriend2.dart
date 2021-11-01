import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class friendsMatchedMoviesFriend2 extends StatelessWidget{
  List<Widget> matchedMovies = <Widget>[]; //empty list of matched movies; gets filled based on the friend clicked

  @override
  Widget build(BuildContext context){
    convertMatchedMoviesToCardsFriend2();
    
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_left_rounded),
            tooltip: 'Go Back to Friends List',
            onPressed: (){
              Navigator.pop(context);
            },),
        title: Text('Karley Waguespack'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(child: ListView(children: matchedMovies)
      ),
    );
  }


  void convertMatchedMoviesToCardsFriend2(){
    matchedMovies.add(Card(child: ListTile(title: Text('The Guilty'))));
    matchedMovies.add(Card(child: ListTile(title: Text('Venom'))));
  }
}