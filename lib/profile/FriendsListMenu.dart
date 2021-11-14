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
        body: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey[900],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  iconSize: 35,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => AddFriend(db, mvm)
                    ));
                  },
                )

              ),
            )
          ),
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
                    cards = [
                      InkWell(
                          child: Container(
                              child: Card(
                                  child: ListTile(
                                      title: Text("No friends added. Click on the button in the corner to add some!",
                                          style: TextStyle(fontSize: 20))))))
                    ];
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

class AddFriend extends StatefulWidget{
  final db;
  final MainViewModel mvm;

  AddFriend(this.db, this.mvm, {Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();

}

class _MyCustomFormState extends State<AddFriend>{

  final usernameFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.transparent,
        body: AlertDialog(
          title: Text('Add a Friend'),
          content: TextField(
            onChanged: (value) { },
            controller: usernameFieldController,
            decoration: InputDecoration(hintText: "Enter your friend's username"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
              Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                String friendUsername = usernameFieldController.text;
                widget.mvm.addFriendToUser(LoginPage.user, friendUsername, true);
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );


  }


}