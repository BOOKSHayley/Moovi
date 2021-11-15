
import "package:flutter/material.dart";
import "package:moovi/database/mainViewModel.dart";
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/accounts/login.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class PendingFriendsList extends StatefulWidget{
  final db;
  const PendingFriendsList(this.db, { Key? key }) : super(key: key);

  @override
  State<PendingFriendsList> createState() => _PendingFriendsList(db);

}

class _PendingFriendsList extends State<PendingFriendsList>{
  late MainViewModel mvm;
  final db;
  _PendingFriendsList(this.db){
    mvm = MainViewModel(db);
  }

  @override
   Widget build(BuildContext context){
     List<Card> pendingFriendsList;
     return Scaffold(
       appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_left_rounded, size: 45),
            tooltip: 'Go Back to Friends List',
            onPressed: (){
              Navigator.pop(context);
            },
        ),
        actions: [
          IconButton(
            iconSize: 35,
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => AddFriend(db, mvm)
              ));
            },
          )
        ],
        title: Text('Add Friends'),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
      width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<UserEntity?>>(
          stream: mvm.getAllFriendsOfUserAsStream(LoginPage.user, true),
          builder: (BuildContext context, AsyncSnapshot<List<UserEntity?>> snapshot){
            if(snapshot.hasError) { print("ERROR!"); }
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.done:
                if(snapshot.hasData){
                  pendingFriendsList = generatePendingFriendsCardsList(snapshot.data!);
                }
                else{
                  pendingFriendsList = [
                    new Card(child: ListTile(title: Text("No pending friends")))
                  ];
                }
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            child: Text(
                              'Your pending friends',
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        child: ListView(children: pendingFriendsList)
                    )
                  ]
                );
            }

          }
      )
      ));
   }

   generatePendingFriendsCardsList(List<UserEntity?> pendingFriendsEntities){
    List<Card> pendingFriendsList = [];
    for(int i = 0; i < pendingFriendsEntities.length; i++){
      if(pendingFriendsEntities[i] == null){
        continue;
      }
      pendingFriendsList.add(new Card(key: ObjectKey(pendingFriendsEntities[i]!.userName),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      pendingFriendsEntities[i]!.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[

                          IconButton(
                            icon: const Icon(Icons.check),
                            tooltip: 'Accept',
                            onPressed: (){
                              setState(() {
                                mvm.updateFriendOfUserFromPending(LoginPage.user, pendingFriendsEntities[i]!.userName);
                              });

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => super.widget));
                            },),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: 'Decline',
                            onPressed: (){
                              setState(() {
                                mvm.removeFriendFromUser(LoginPage.user, pendingFriendsEntities[i]!.userName);
                              });

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => super.widget));
                            },)
                        ]
                    )
              ]
         )
      )
      );
    }
    return pendingFriendsList;
  }




  //  void removePendingFriend(ObjectKey key, Widget element){
  //     setState(() {
  //       pendingFriends.removeWhere((element) => element.key == key);
  //     });
  //  }

  //  void addPendingFriends(){
  //    pendingFriends.add(Card(
  //       key: ObjectKey('Lucas'),
  //       child: Row(
  //             children: <Widget>[
  //                 Text('Lucas Colegrove'),
  //                 ButtonBar(
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: const Icon(Icons.check),
  //                       tooltip: 'Accept',
  //                       onPressed: (){
  //                           setState(() {
  //                             //add friend to list of user's friends
  //                             //Need to update the state of the friends list
  //                             pendingFriends.removeWhere((element) => element.key == ObjectKey('Lucas'));
  //                           });
  //                       },),
  //                       IconButton(
  //                       icon: const Icon(Icons.clear),
  //                       tooltip: 'Decline',
  //                       onPressed: (){
  //                           setState(() {
  //                             pendingFriends.removeWhere((element) => element.key == ObjectKey('Lucas'));
  //                           });
  //                       },)
  //                   ]
  //                 )
  //             ],)
  //      ));
  //    Card(child: ListTile(title: Text('Chris Bowen')));
  //    Card(child: ListTile(title: Text('Robert Fahey')));
     

  //  }

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
  final errorFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameFieldController.dispose();
    errorFieldController.dispose();
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
              onPressed: () async {
                String friendUsername = usernameFieldController.text;
                bool successful = await widget.mvm.addFriendToUser(LoginPage.user, friendUsername, true);
                if(successful) {
                  Navigator.of(context).pop();
                } else{
                  usernameFieldController.clear();
                  UserEntity? exists = await widget.mvm.getUserbyUsername(friendUsername);
                  if(exists != null){
                    errorFieldController.text = "You've already added this person as a friend.";
                  } else{
                    errorFieldController.text = "Invalid username.";
                  }
                }
              },
            ),
            TextField(
              controller: errorFieldController,
              readOnly: true,
            )
          ],
        )
    );


  }


}



