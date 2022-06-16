


import 'package:flutter/material.dart';
import 'package:moovi/database/movieEntity.dart';

class ProfileMovieList {

  static List<InkWell> buildMovieCards(BuildContext context, List<MovieEntity?> movies, InkWell noMovie) {
    List<InkWell> cards = [];
    if (movies.length == 0) {
      cards = [ noMovie ];
    } else {
      for (int i = 0; i < movies.length; i++) {
        cards.add(InkWell(
          child: Container(
            width: (MediaQuery.of(context).size.width) / 2,
            height: (MediaQuery.of(context).size.width) / 2 * (3 / 2),
            child: Card(
              child: Container(
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/CuteCow_transparent.png",
                  image: movies[i]!.imageUrl,
                )
              ),
            )
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return showInfo(movies[i]!);
              }
            );
          },
        ));
      }
    }
    return cards;
  }


  static Container showInfo(MovieEntity movie) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Movie Information:", style: TextStyle(fontSize: 26),),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Divider(thickness: 4,),
                  movieLines("Title", movie.title),
                  movieLines("Year", movie.year.toString()),
                  movieLines("Rated", movie.mpaa),
                  movieLines("Runtime", movie.runtime),
                  movieLines("IMDB Rating", movie.imdb.toString() + "/10"),
                  movieLines("Genres", movie.genres),
                  movieLines("Synopsis", movie.synopsis),
                  movieLines("Available on", movie.streamingService),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Wrap movieLines(String firstText, String secondText) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(2),
          child: Text(firstText + ":  ",
            style: TextStyle(fontSize: 25, color: Colors.yellow),),
        ),
        Padding(
          padding: EdgeInsets.all(2),
          child: Text(secondText, style: TextStyle(fontSize: 25,),),
        ),
        Divider()
      ],
    );
  }

}