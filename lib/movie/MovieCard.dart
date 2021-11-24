import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/database/movieEntity.dart';
import '../main.dart';
import 'likeDislikeBackend.dart';
import 'package:flip_card/flip_card.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final username;
  MovieCard(this.username, this.movie);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: FlipCard(
        fill: Fill.fillBack,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child:FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              placeholder: "assets/CuteYellowCow_transparent.png",
              image: movie.imageUrl,
            ),
          ),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color(0xff1a1d21),
            borderRadius: BorderRadius.circular(16.0)
          ),
          margin: EdgeInsets.only(top: 40.0),
        ),
        back: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: _getShadowedTextStyle()
                )
              ),

              Text(
                movie.year.toString(),
                style: TextStyle(fontSize: 18)
              ),

              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(color: Colors.white)
              ),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Container(
                        child: Text(
                          "Rated " + movie.mpaa,
                          style: _getShadowedTextStyle()
                        ),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.access_time),
                            Text(
                              " " + movie.runtime,
                              style: _getShadowedTextStyle()
                            )
                          ]
                        ),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "IMDB Rating: ",
                              style: _getShadowedTextStyle()
                            ),
                            Row(
                              children: [
                                Icon(Icons.star),
                                Text(
                                  movie.imdb.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: _getRatingColor(movie.imdb),
                                    shadows: <Shadow>[Shadow(
                                      offset: Offset(3, 3),
                                      blurRadius: 5,
                                      color: Color.fromARGB(255, 33, 10, 6)
                                    )]
                                  )
                                ),
                                Text(
                                  "/10",
                                  style: TextStyle(fontSize: 18)
                                )
                              ]
                            )
                          ]
                        ),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Container(
                        child: Text(
                          movie.genres,
                          textAlign: TextAlign.left,
                          style: _getShadowedTextStyle()
                        ),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 20),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "Available on: ",
                              style: _getShadowedTextStyle()
                            ),
                            Image.network("https://www.freepnglogos.com/uploads/netflix-logo-0.png",
                              height: 20,
                              width: 60
                            )
                          ]
                        ),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Divider(color: Colors.white)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        child: Text(
                          movie.synopsis,
                          textAlign: TextAlign.left,
                          // style: _getShadowedTextStyle()
                        ),
                      )
                    ),
                  ]
                ),
              )
            ]
          ),),
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            color: const Color(0xff282b31),
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     const Color(0xffff7300),
            //     Colors.yellow
            //   ]
            // ),
            borderRadius: BorderRadius.circular(16.0)
          )
        ),
      ),
      verticalSwipe: false,
      onSwipeLeft: (position){onDislikeClicked(MyApp.user, movie);},
      onSwipeRight: (position){onLikeClicked(MyApp.user, movie);},
    );
  }

  TextStyle _getShadowedTextStyle(){
    return TextStyle(
      fontSize: 25,
      fontFamily: 'thebold',
      );
  }

  Color _getRatingColor(double rating){
    if(rating < 5) return Colors.red;
    if(rating < 7) return Colors.yellow;
    if(rating <= 10) return Colors.green;
    else return Colors.white;
  }
}