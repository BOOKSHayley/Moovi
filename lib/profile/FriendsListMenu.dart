import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:moovi/accounts/login.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/userEntity.dart';
import 'FriendProfile.dart';
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
          title: Text('Friends List'),
        ),
        body: Column(
        children: [

        StreamBuilder<List<UserEntity?>>(
            stream: mvm.getAllFriendsOfUserAsStream(LoginPage.user, false),
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
                    cards = [ noFriends() ];
                  }
                  return Expanded(
                      child: ListView(children: cards)
                  );
              }
            })]),
            floatingActionButton: FloatingActionButton(
                    onPressed: () {
                        Navigator.of(context)
                        .push(
                            MaterialPageRoute(builder: (context) => PendingFriendsList(db))
                        );
                    },
                    child: const Icon(Icons.person_add),
                    backgroundColor: Colors.green,)
    );
  }

  List<InkWell> buildFriendCards(List<UserEntity?> friends, BuildContext context) {
    List<InkWell> cards = [];

    if(friends.length == 0){
      cards = [ noFriends() ];
    } else {
      for (int i = 0; i < friends.length; i++) {
        cards.add(InkWell(
            child: Card(
                child: ListTile(
                    title: Text(friends[i]!.name,
                        style: TextStyle(fontSize: 20)))),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      FriendMatchedCard(
                          friends[i]!.userName, friends[i]!.name, mvm)));
            }));
      }
    }

    return cards;
  }

  InkWell noFriends(){
      return InkWell(
          child: Container(
              child: Card(
                  child: ListTile(
                      title: Text("No friends added. Click on the button in the corner to add some!",
                          style: TextStyle(fontSize: 20))))));
  }
}
