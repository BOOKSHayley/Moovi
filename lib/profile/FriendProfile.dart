
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/Theme/MooviCowProfile.dart';
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import '../Theme/MooviProgressIndicator.dart';

class FriendMatchedCard extends StatefulWidget {
  final friendUsername;
  final friendName;
  final MainViewModel mvm;

  const FriendMatchedCard(this.friendUsername, this.friendName, this.mvm, {Key? key}) : super(key: key);

  _FriendMatchedCard createState() => _FriendMatchedCard(friendUsername, friendName, mvm);
}

class _FriendMatchedCard extends State<FriendMatchedCard>{
  final friendUsername;
  final friendName;
  late final MainViewModel mvm;
  _FriendMatchedCard(this.friendUsername, this.friendName, this.mvm);

//ListView.builder

  @override
  Widget build(BuildContext context){
    List<Card> cards = [];
    return Scaffold(
      body: Center(
          child: Container(
              child: StreamBuilder<List<MovieEntity?>>(
                  stream: mvm.getSharedLikedMoviesAsStream(LoginPage.user, friendUsername),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MovieEntity?>> snapshot) {
                    if(snapshot.hasError) { print("ERROR!"); }
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return MooviProgressIndicator();
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          cards = buildMatchedMovieCards(snapshot.data!);
                        } else {
                          cards = [ noMovies() ];
                        }
                        return FriendProfile(mvm, widget.friendUsername, widget.friendName, cards);
                    }
                  }))
      ),
    );
  }

  List<Card> buildMatchedMovieCards(List<MovieEntity?> movies){
    List<Card> cards = [];
    if(movies.length == 0){
      cards = [ noMovies() ];
    } else {
      for (int i = 0; i < movies.length; i++) {
        cards.add(
          Card(
            child: InkWell(
              child: Container( //ListTile(title: Text(movies[i]!.title, style: TextStyle(fontSize: 20)))
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/CuteYellowCow_transparent.png",
                  image: movies[i]!.imageUrl,
                )
              ),
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return showInfo(movies[i]!);
                  }
                );
              },
            )
          )
        );
      }
    }
    return cards;
  }

  Container showInfo(MovieEntity movie){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding( padding: EdgeInsets.all(5),),
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

  Wrap movieLines(String firstText, String secondText){
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(2),
          child: Text(firstText + ":  ", style: TextStyle(fontSize: 25, color: Colors.yellow),),
        ),
        Padding(
          padding: EdgeInsets.all(2),
          child: Text(secondText, style: TextStyle(fontSize: 25,),),
        ),
        Divider()
      ],
    );
  }


  Card noMovies(){
    return Card(child: ListTile(title: Text("No shared movies with " + friendName + " yet. :(", style: TextStyle(fontSize: 20),)));
  }


}

class FriendProfile extends StatelessWidget{
  final friendUsername;
  final name;
  final cardList;
  final MainViewModel mvm;
  const FriendProfile(this.mvm, this.friendUsername, this.name, this.cardList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 190,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff353d47), width: 5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xffff7300),
                      Colors.yellow,
                    ],
                  )
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: Stack(
                              children: <Widget> [
                                Positioned(
                                  top: 3,
                                  left: 3,
                                  child: IconButton(
                                    iconSize: 25,
                                    icon: const Icon(
                                        Icons.arrow_back,
                                        color: const Color.fromARGB(
                                            255, 151, 85, 39),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                IconButton(
                                  iconSize: 25,
                                  icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )
                          ),
                          Row(
                            children: [
                              MooviCowProfile(),
                              Padding(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 5,
                                                color: Color.fromARGB(
                                                    255, 33, 10, 6),
                                              ),
                                            ],
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,

                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "@" + friendUsername,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 6,
                                                color: Color.fromARGB(
                                                    255, 24, 7, 4),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ]
                                ),
                              )

                            ],
                          ),

                        ],
                      )

                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Remove Friend"),
                              value: 1,
                            )
                          ],

                          onSelected: (result) {
                            if (result == 1) {
                              mvm.removeFriendFromUser(LoginPage.user, friendUsername);
                              Navigator.pop(context);
                            }

                          },

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                          child: Stack(
                          children: <Widget>[
                          Positioned(
                            left: 3,
                            top: 3,

                            child: Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Color.fromARGB(
                                  255, 151, 85, 39),

                            ),

                          ),
                          Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colors.white

                          ),
                          ],
                        ),
                        ),


                      ),
                    )

                  ]

              )
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    'Your shared movies',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              )
          ),
          Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: cardList,
                    )
                  ]
              )
          ),
        ],
      ),
    );

  }


}