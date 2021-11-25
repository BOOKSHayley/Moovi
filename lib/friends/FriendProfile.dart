
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/Theme/MooviCowProfile.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/database/userEntity.dart';
import '../Theme/MooviProgressIndicator.dart';
import '../main.dart';
import 'FriendsListMenu.dart';
import '../profile/ProfileMovieList.dart';

class FriendMatchedCard extends StatefulWidget {
  final friend;
  final _numSharedMovies;

  FriendMatchedCard(this.friend, this._numSharedMovies, {Key? key}) : super(key: key);

  _FriendMatchedCard createState() => _FriendMatchedCard(friend, _numSharedMovies);
}

class _FriendMatchedCard extends State<FriendMatchedCard> {
  final _numSharedMovies;
  late UserEntity friend;
  bool globalVar = true;

  _FriendMatchedCard(this.friend, this._numSharedMovies);

  @override
  Widget build(BuildContext context) {
    List<InkWell> cards = [];
    return Scaffold(
      body: Center(
        child: Container(
          child: StreamBuilder<List<MovieEntity?>>(
            stream: MyApp.mvm.getSharedLikedMoviesAsStream(MyApp.user, friend),
            builder: (BuildContext context,
                AsyncSnapshot<List<MovieEntity?>> snapshot) {
              if (snapshot.hasError) {
                print("ERROR!");
              }
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return MooviProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    cards = ProfileMovieList.buildMovieCards(context, snapshot.data!, noMovies());//buildMatchedMovieCards(snapshot.data!);
                  } else {
                    cards = [ noMovies()];
                  }
                  return FriendProfile(friend, cards, _numSharedMovies);
              }
            }))
      ),
    );
  }

  InkWell noMovies() {
    return InkWell(
      child: Card(
        child: ListTile(title: Text("No shared movies with " + friend.name + " yet. :(", style: TextStyle(fontSize: 20),))
      ));
  }

}

class FriendProfile extends StatelessWidget{
  final friend;
  final cardList;
  final _numSharedMovies;
  const FriendProfile(this.friend, this.cardList, this._numSharedMovies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 175,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner-angles.jpg'),
                  fit: BoxFit.fill,
                )
              // border: Border.all(color: Color(0xff353d47), width: 5),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     const Color(0xffff7300),
              //     Colors.yellow,
              //   ],
              // )
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
                                icon: const Icon( Icons.arrow_back, color: const Color.fromARGB(255, 151, 85, 39),),
                                onPressed: () {
                                  // Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => MenusStatefulWidget(2)), (_) => false
                                  );
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
                                // Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => MenusStatefulWidget(2)), (_) => false
                                );
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
                                    friend.name,
                                    style: TextStyle(
                                      shadows: <Shadow>[
                                        Shadow(offset: Offset(3, 3), blurRadius: 5, color: Color.fromARGB(255, 33, 10, 6),
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
                                    "@" + friend.userName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(3, 3),
                                          blurRadius: 6,
                                          color: Color.fromARGB(255, 24, 7, 4),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                              MyApp.mvm.removeFriendFromUser(MyApp.user, friend);
                              Navigator.pop(context);
                            }

                          },

                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Icon(
                                Icons.more_vert,
                                size: 30,
                                color: Colors.white
                            ),
                          )

                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Container(
                        // color: Colors.grey[900],
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(3),
                              child: Image.asset("assets/Popcorn_transparent.png", width: 40, height: 40,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3, right: 15),
                              child: Text(
                                friend.numClicks.toString(),
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ]
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Text(
                  _numSharedMovies.toString() + ' Shared Movies With ' + friend.name,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            )
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              scrollDirection: Axis.vertical,
                children: <Widget>[
                  Wrap(
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