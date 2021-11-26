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
                padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'brandon',
                  )
                )
              ),

              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(color: Colors.white)
              ),

              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              movie.year.toString(),
                              style: TextStyle(fontSize: 18)
                          ),
                          Container(
                                child: Text(
                                    movie.mpaa,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'brandon',
                                    )
                                ),
                              ),
                          Row(
                                children: [
                                  Icon(Icons.access_time),
                                  Text(
                                    " " + movie.runtime,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'brandon',
                                    ),
                                  )
                                ]
                            ),
                        ]
                    )
                )
              ),

                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Container(
                              child: Row(
                                  children: [
                                    Text(
                                      "IMDB Rating: ",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'brandon',
                                      ),
                                    ),
                                    Row(
                                        children: [
                                          Icon(Icons.star),
                                          Text(
                                              movie.imdb.toString(),
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: _getRatingColor(movie.imdb),
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
                            padding: EdgeInsets.only(top: 10),
                            child: Divider(color: Colors.white)
                        ),

                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                              child: Text(
                                  movie.synopsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: const Color(0xffc2c2c2),
                                    fontSize: 20,
                                    fontFamily: 'brandon',
                                  )
                              ),
                            )
                        ),
                      ]
                  ),
                  )
                )
            ]
          ),),
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            //color: const Color(0xff282b31),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff282b31),
                const Color(0xffe07d5f),
              ]
            ),
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
      fontFamily: 'brandon',
      );
  }

  Color _getRatingColor(double rating){
    if(rating < 5) return const Color(0xffaf4646);
    if(rating < 7) return const Color(0xffefb24d);
    if(rating <= 10) return const Color(0xff9aec6e);
    else return Colors.white;
  }
}