
import "package:flutter/material.dart";
import 'package:moovi/Theme/MooviCowProfile.dart';
import 'package:moovi/Theme/MooviProgressIndicator.dart';
import "package:moovi/database/mainViewModel.dart";
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/accounts/login.dart';

import 'AddFriend.dart';

class PendingFriendsList extends StatefulWidget{
  final db;
  static int numPending = 0;
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
          title: Text('Add Friends', style: TextStyle(fontSize: 26)),
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
                  return MooviProgressIndicator();
                case ConnectionState.done:
                  if(snapshot.hasData){
                    pendingFriendsList = generatePendingFriendsCardsList(snapshot.data!);
                    PendingFriendsList.numPending = pendingFriendsList.length;
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
                              style: TextStyle(color: Colors.grey, fontSize: 22),
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
         child:
         Container(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: MooviCowProfile()
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        pendingFriendsEntities[i]!.name,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                      tooltip: 'Accept',
                      onPressed: (){
                        mvm.updateFriendOfUserFromPending(LoginPage.user, pendingFriendsEntities[i]!.userName);
                        setState(() { PendingFriendsList.numPending -= 1; });
                      },),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.red,
                      tooltip: 'Decline',
                      onPressed: (){
                        mvm.removeFriendFromUser(LoginPage.user, pendingFriendsEntities[i]!.userName);
                        setState(() { PendingFriendsList.numPending -= 1; });
                      },)
                  ]
                  )
              ]
           )
      ))
      );
    }
    return pendingFriendsList;
  }

}



