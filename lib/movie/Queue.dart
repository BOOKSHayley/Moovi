import 'package:flutter/material.dart';
import 'package:moovi/Theme/MooviProgressIndicator.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/main.dart';
import 'package:moovi/movie/MovieCardStack.dart';
import 'MovieCard.dart';


class Queue extends StatefulWidget {
  const Queue({Key? key}) : super(key: key);

  @override
  QueueState createState() => QueueState();
}

class QueueState extends State<Queue> with SingleTickerProviderStateMixin {
  final user = MyApp.user;
  final stackKey = GlobalKey<MovieCardStackState>();

  @override
  Widget build(BuildContext context) {
    List<MovieCard> cardsList;
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder<List<MovieEntity?>>(
        stream: MyApp.mvm.getMoviesInPersonalQueueAsStream(user, MyApp.genres),
        builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
          if(snapshot.hasError) { print("ERROR!"); }
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return MooviProgressIndicator();
            case ConnectionState.done:
              if(snapshot.hasData){
                int length = snapshot.data!.length;
                if(length >= 10){
                  cardsList = generateCardsList(snapshot.data!.take(10).toList());
                } else {
                  cardsList = generateCardsList(snapshot.data!.take(length).toList());
                }
              }
              else{
                cardsList = [ noMovie() ];
              }
              return MovieCardStack(cardsList);
          }
        }
      ),
    );
  }

  generateCardsList(List<MovieEntity?> movieEntities){
    List<MovieCard> cardList = [];
    cardList.add(noMovie());
    for(int i = 0; i < movieEntities.length; i++){
      if(movieEntities[i] == null){
        continue;
      }
      cardList.add(new MovieCard(user.userName, movieEntities[i]!));
    }


    return cardList;
  }

  MovieCard noMovie(){
    return new MovieCard(user.userName, new MovieEntity(null, "Ran out of Movies. :(",
        "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg",
        "mpaa", 10, "runtime", "genres", 0000, "None", "It's impressive that you've got this far!"));
  }

}

