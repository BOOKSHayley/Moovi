import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/profile/FriendsListMenu.dart';
import 'package:moovi/movie/Movie.dart';
import 'accounts/login.dart';
import 'database/DatabaseGetter.dart';
import 'database/mainViewModel.dart';
import 'profile/UserProfile.dart';
import 'movie/QueueMenu.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _database = await DatabaseGetter.instance.database;
  final MainViewModel mvm = MainViewModel(_database);

  //TODO: Clean up main.dart
  //Get rid of database stuff
  //Move the Material App stuff so only the ref to Login is here. Move rest into another dart file
  runApp(MaterialApp(home:LoginPage(_database, mvm), theme: ThemeData(brightness: Brightness.dark),));


  //IF YOU ARE RUNNING FOR FIRST TIME:
  //1. COMMENT OUT THE RUN APP METHOD
  //2. UNCOMMENT LINES BELOW. RUN, WAIT FOR PRINT STATEMENTS, STOP, COMMENT LINES AGAIN
  // await mvm.clearAllTables();
  // await mvm.clearMovieTable();
  // print("Cleared t");
  // List<MovieEntity?> movies = await mvm.getAllMovies();
  // print(movies.length);


}

class MyApp extends StatelessWidget{
  final db;
  const MyApp(this.db, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOVI',
      home: MenusStatefulWidget(db),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MenusStatefulWidget extends StatefulWidget {
  final db;
  const MenusStatefulWidget(this.db, {Key? key}) : super(key: key);

  @override
  State<MenusStatefulWidget> createState() => _MenusStatefulWidgetState(db);
}

class _MenusStatefulWidgetState extends State<MenusStatefulWidget> {
  final db;
  int _selectedIndex = 1;
  late List<Widget> _widgetOptions;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  _MenusStatefulWidgetState(this.db) {

  _widgetOptions = <Widget>[ //List of widgets for the screen
    LikedList(db),
    QueueMenu(db),
    FriendsListMenu(db)
  ];
}
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Liked Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Friends',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
