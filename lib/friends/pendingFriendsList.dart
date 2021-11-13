
import "package:flutter/material.dart";
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class PendingFriendsList extends StatefulWidget{
  const PendingFriendsList({ Key? key }) : super(key: key);

  @override
  State<PendingFriendsList> createState() => _PendingFriendsList();

}

class _PendingFriendsList extends State<PendingFriendsList>{
  List<Widget> pendingFriends = <Widget>[]; 

  @override
   Widget build(BuildContext context){
     addPendingFriends();
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
      body: Center(child: ListView(children: pendingFriends)
      )
      );
   }


   void removePendingFriend(ObjectKey key, Widget element){
      setState(() {
        pendingFriends.removeWhere((element) => element.key == key);
      });
   }

   void addPendingFriends(){
     pendingFriends.add(Card(
        key: ObjectKey('Lucas'),
        child: Row(
              children: <Widget>[
                  Text('Lucas Colegrove'),
                  ButtonBar(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.check),
                        tooltip: 'Accept',
                        onPressed: (){
                          //TODO
                        },),
                        IconButton(
                        icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(Icons.add),
                              ),
                        tooltip: 'Decline',
                        onPressed: (){
                          //TODO
                        },)
                    ]
                  )
              ],)
       ));
     Card(child: ListTile(title: Text('Chris Bowen')));
     Card(child: ListTile(title: Text('Robert Fahey')));
     

   }

}



// class _PendingFriendsList extends State<PendingFriendsList> {
//   static const historyLength = 5;
//   List<String> _searchHistory = [
//       'fuchsia',
//       'flutter',
//       'widgets',
//       'resocoder',
//   ];

//   String selectedTerm;

//   List<String> filteredSearchHistory;

//   List<String> filterSearchTerms({
//     @required String filter;
//   }){
//       if(filter != null && filter.isNotEmpty){
//         return _searchHistory.reversed.where((term) => term.startsWith(filter))
//         .toList();
//       }
//       else{
//         return _searchHistory.reversed.toList();
//       }
//   }

//   void addSearchTerm(String term){
//     if (_searchHistory.contains(term)){
//       putSearchTermFirst(term);
//       return;
//     }
//     _searchHistory.add(term);
//     if(_searchHistory.length > historyLength){
//       _searchHistory.removeRange(0, _searchHistory.length-historyLength);
//     }

//     filteredSearchHistory = filterSearchTerms(filter: null);
//   }

//   void deleteSearchTerm(String term){
//     _searchHistory.removeWhere((t) => t == term);
//     filteredSearchHistory  = filterSearchTerms(filter: null);
//   }

//   void putSearchTermFirst(String term){
//     deleteSearchTerm(term);
//     addSearchTerm(term);
//   }

//   FloatingSearchBarController controller;

//   @override
//   void initState(){
//     super.initState();
//     controller = FloatingSearchBarController();
//     filteredSearchHistory = filterSearchTerms(filter: null);
//   }


//   @override 
//   void dispose(){
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//    Widget build(BuildContext context){
//      return Scaffold(
//        body: FloatingSearchBar(
//          controller: controller,
//          body: FloatingSearchBarScrollNotifier(
//            child: SearchResultsListView(
//               searchTerm: null,
//          ),
//          ),
//          transition: CircularFloatingSearchBarTransition(),
//          physics: BouncingScrollPhysics(),
//          title: Text(
//            selectedTerm ?? 'Friend Name',
//            style: Theme.of(context).textTheme.headline6
//          ),
//          hint: 'Friend Name...',
//          actions: [
//            FloatingSearchBarAction.searchToClear(),
//          ],
//          onQueryChanged: (query){
//            setState(setState(() {
//              filteredSearchHistory = filterSearchTerms(filter: query);
//            });
//            },

//            onSubmitted: (query){
//              setState((setState(() {
//                addSearchTerm(query);
//                selectedTerm = query;
//              });

//          controller.close();
//              },

//           builder: (context, transition){
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Material(
//                 color: Colors.white,
//                 elevation: 4,
//                 child: Placeholder(fallbackHeight: 200,),
//               )
//             );
//           }
//              )
//            },
//          },
//      );
//       // return Scaffold(
//       //   appBar: AppBar(
//       //   leading: IconButton(
//       //       icon: const Icon(Icons.arrow_left_rounded),
//       //       tooltip: 'Go Back to Friends List',
//       //       onPressed: (){
//       //         Navigator.pop(context);
//       //       },),
//       //       title: Text('Add Friends'),
//       //       backgroundColor: Colors.blueAccent,),
//       //   // body: FloatingSearchBar(
//       //   //   controller: controller,
//       //   //   body: SearchResultsListView()
//       //   //     searchTerm: null,
//       //   // ) 
//       // );
// }}

// // class SearchResultsListView extends StatefulWidget{
// //   final String searchTerm;

// // }