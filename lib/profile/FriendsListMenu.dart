import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/userEntity.dart';
import 'FriendMatchedCard.dart';
import 'package:moovi/friends/pendingFriendsList.dart';

class FriendsListMenu extends StatefulWidget {
  final db;
  const FriendsListMenu(this.db, {Key? key}) : super(key: key);

  _FriendsListMenu createState() => _FriendsListMenu(db);
}

class _FriendsListMenu extends State<FriendsListMenu> {
  late MainViewModel mvm;
  final db;
  _FriendsListMenu(this.db){
    mvm = MainViewModel(db);
  }

  @override
  Widget build(BuildContext context) {
    List<InkWell> cards = [];
    return Scaffold(
        appBar: AppBar(
          title: Text("Friends!", style: TextStyle(fontSize: 28),),
          backgroundColor: Colors.black54,
        ),
        body: Container(
        child: StreamBuilder<List<UserEntity?>>(
            stream: mvm.getAllFriendsOfUserAsStream(LoginPage.username, false),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserEntity?>> snapshot) {
              if(snapshot.hasError) { print("ERROR!"); }
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator(),);
                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    cards = buildFriendCards(snapshot.data!, context);
                  } else {
                    cards = [
                      InkWell(
                          child: Container(
                              child: Card(
                                  child: ListTile(
                                      title: Text("No friends added. Click on the button in the corner to add some!",
                                          style: TextStyle(fontSize: 20))))))
                    ];
                  }
                  return ListView(children: cards,);
              }
            })),
            floatingActionButton: FloatingActionButton(
                    onPressed: () {
                        Navigator.of(context)
                        .push(
                            MaterialPageRoute(builder: (context) => PendingFriendsList())
                        );
                    },
                    child: const Icon(Icons.person_add),
                    backgroundColor: Colors.green,)
    );
  }

  List<InkWell> buildFriendCards(List<UserEntity?> friends, BuildContext context) {
    List<InkWell> cards = [];
    for (int i = 0; i < friends.length; i++) {
      cards.add(InkWell(
          child: Card(
              child: ListTile(
                  title: Text(friends[i]!.name,
                      style: TextStyle(fontSize: 20)))),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FriendMatchedCard(
                    friends[i]!.userName, friends[i]!.name, mvm)));
          }));
    }

    return cards;
  }
}