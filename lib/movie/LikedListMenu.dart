
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/movieEntity.dart';

class LikedListMenu extends StatefulWidget {
  final db;
  const LikedListMenu(this.db, {Key? key}) : super(key: key);

  @override
  _LikedListMenu createState() => _LikedListMenu(db);
}


class _LikedListMenu extends State<LikedListMenu>{
  late Stream<List<MovieEntity?>> stream;
    @override
    void initState() {
      super.initState();
      stream =  mvm.getLikedMoviesOfUserAsStream(username);
    }
    final db;
    final username = "H1";
    late MainViewModel mvm;
    _LikedListMenu(this.db){
      mvm = new MainViewModel(db);
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        child: StreamBuilder<List<MovieEntity?>>(
            stream: stream,
            builder: (BuildContext context,
                AsyncSnapshot<List<MovieEntity?>> snapshot) {
              return snapshot.hasData
                  ? new ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                        print(snapshot.data![index]!.title);
                        return Card(child: ListTile(title: Text(snapshot.data![index]!.title)));
                      }
                  )
                  : Card(
                    child: ListTile(
                      title: Text("No Liked Movies yet!"),
                    ),
                  );
              }
              ));
    }

    // List<Card> buildCards(List<MovieEntity?> movieEntities){
    //   List<Card> likedMovies = [];
    //   for(int i = 0; i < movieEntities.length; i++){
    //     if(movieEntities[i] == null){
    //       continue;
    //     }
    //     print(movieEntities[i]!.title);
    //     likedMovies.add(new Card(child: ListTile(title: Text(movieEntities[i]!.title))));
    //   }
    //   return likedMovies;
    // }
}

