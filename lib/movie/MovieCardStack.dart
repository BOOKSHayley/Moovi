import 'package:flutter/material.dart';
import 'MovieCard.dart';

class MovieCardStack extends StatefulWidget{
  final List<MovieCard> cardsArray;
  const MovieCardStack(this.cardsArray, {Key? key}) : super(key: key);

  @override
  MovieCardStackState createState() => MovieCardStackState(cardsArray);
}

class MovieCardStackState extends State<MovieCardStack>{
  final List<MovieCard> cardsArray;
  MovieCardStackState(this.cardsArray);

  @override
  Widget build(BuildContext context) {
    return Stack(children: cardsArray);
  }
}