
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
            icon: const Icon(Icons.arrow_left_rounded),
            tooltip: 'Go Back to Friends List',
            onPressed: (){
              Navigator.pop(context);
            },),
        title: Text('My Pending Friends'),
        backgroundColor: Colors.blueAccent,
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
                return ListView(children: pendingFriendsList);}}
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
              children: <Widget>[
                  Text(pendingFriendsEntities[i]!.name),
                  ButtonBar(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.check),
                        tooltip: 'Accept',
                        onPressed: (){
                          mvm.updateFriendOfUserFromPending(LoginPage.user, pendingFriendsEntities[i]!.userName);
                          mvm.removeFriendFromUser(LoginPage.user, pendingFriendsEntities[i]!.userName);

                        },),
                        IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: 'Decline',
                        onPressed: (){
                            mvm.removeFriendFromUser(LoginPage.user, pendingFriendsEntities[i]!.userName);
                        },)
                    ]
                  )])));
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



