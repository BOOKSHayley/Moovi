import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class Movie
{
  String _movieTitle;
  String _imageLink;
  String _MPAA_Rating;
  double _IMDB_Rating;
  String _movieRuntime;
  String _movieGenre;
  String _movieSynopsis;

  Movie(this._movieTitle, this._imageLink, this._MPAA_Rating, this._IMDB_Rating,
      this._movieRuntime, this._movieGenre, this._movieSynopsis);


  String get movieSynopsis => _movieSynopsis;

  set movieSynopsis(String value) {
    _movieSynopsis = value;
  }

  String get movieGenre => _movieGenre;

  set movieGenre(String value) {
    _movieGenre = value;
  }

  String get movieRuntime => _movieRuntime;

  set movieRuntime(String value) {
    _movieRuntime = value;
  }

  double get IMDB_Rating => _IMDB_Rating;

  set IMDB_Rating(double value) {
    _IMDB_Rating = value;
  }

  String get MPAA_Rating => _MPAA_Rating;

  set MPAA_Rating(String value) {
    _MPAA_Rating = value;
  }

  String get imageLink => _imageLink;

  set imageLink(String value) {
    _imageLink = value;
  }

  String get movieTitle => _movieTitle;

  set movieTitle(String value) {
    _movieTitle = value;
  }

  @override
  String toString() {
    return 'Movie{_movieTitle: $_movieTitle, _imageLink: $_imageLink, _MPAA_Rating: $_MPAA_Rating, _IMDB_Rating: $_IMDB_Rating, _movieRuntime: $_movieRuntime, _movieGenre: $_movieGenre, _movieSynopsis: $_movieSynopsis}';
  }


  //these can be combined
  static generateQueue() async {

    File movieInfo = new File('/queue.txt');

    try{

      var queue = processData(movieInfo.readAsLines() as List<String>);
      processData(queue);



    }catch(e){

    }

  }

  static processData( List<String> lines){
    print("Hello");
    var queue;
    for (var line in lines) {
      print(line);
      try {
        var temp = line.split(";");
        queue.add( new Movie( temp.elementAt(0),temp.elementAt(1),temp.elementAt(2),
                              temp.elementAt(3) as double,temp.elementAt(4),temp.elementAt(5),
                              temp.elementAt(6)));

      }catch (e){

      }
    }
    return queue;
  }
}