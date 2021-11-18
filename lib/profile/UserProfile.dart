import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moovi/Theme/MooviCowProfile.dart';
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';
import '../Theme/MooviProgressIndicator.dart';
import 'ProfileMovieList.dart';


class LikedList extends StatefulWidget {
  final db;
  const LikedList(this.db, {Key? key}) : super(key: key);

  @override
  _LikedList createState() => _LikedList(db);
}

class _LikedList extends State<LikedList> {
  final db;
  late MainViewModel mvm;
  _LikedList(this.db){
    mvm = new MainViewModel(db);
  }

  @override
  Widget build(BuildContext context) {
    var user = LoginPage.user;
    String name = user.name; //dummy value
    List<InkWell> cardsList;
    return Container(
      width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<MovieEntity?>>(
        stream: mvm.getLikedMoviesOfUserAsStream(LoginPage.user),
        builder: (BuildContext context, AsyncSnapshot<List<MovieEntity?>> snapshot){
          if(snapshot.hasError) { print("ERROR!"); }
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return MooviProgressIndicator();
            case ConnectionState.done:
              if(snapshot.hasData){
                cardsList = ProfileMovieList.buildMovieCards(context, snapshot.data!, noMovies());//generateCardList(snapshot.data!);
              }
              else{
                cardsList = [ noMovies() ];
              }
              return UserProfile(db, mvm, user.userName, name, cardsList);
          }

        }
      ),
    );
  }

  InkWell noMovies(){
    return InkWell(
      child: Card(
        child: ListTile(
          title: Text("No liked movies yet. Go back to the queue and like some!", style: TextStyle(fontSize: 20),)
        )
      )
    );
  }

}

class UserProfile extends StatelessWidget{
  final username;
  final name;
  final cardList;
  final db;
  final mvm;
  const UserProfile(this.db, this.mvm, this.username, this.name, this.cardList, {Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: MooviCowProfile(),
                            ),
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
                                            color: Color.fromARGB(255, 33, 10, 6),
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
                                      "@" + username,
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
                      ),

                    ],
                  )

                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Align(
                        alignment: Alignment.topRight,

                        child: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Logout"),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text("Edit Profile"),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text("Settings"),
                              value: 3,
                            )
                          ],

                          onSelected: (result) {
                            if (result == 1) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage(db, mvm)),
                                      (_) => false
                              );
                            } else if (result == 2){
                              //todo: create an 'edit profile' page and use navigator
                            } else{
                              //todo: create a settings page and use navigator
                            }
                          },

                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[900]!, width: 2),
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
                                  color: Color.fromARGB(255, 151, 85, 39),
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
                    ),
                    Container(
                      // color: Colors.grey[900],
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
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
                              LoginPage.user.numClicks.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
                          )
                        ],
                      ),
                    )
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
                  'Your liked moves',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            )
          ),
          Expanded(
            child: ListView(
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

//todo: for future implementation
class Settings extends StatelessWidget{
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(

    );

  }


}

