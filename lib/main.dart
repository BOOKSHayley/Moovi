import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moovi/database/database.dart';
import 'package:moovi/database/movieEntity.dart';
import 'package:moovi/movie/Movie.dart';
import 'database/DatabaseGetter.dart';
import 'database/mainViewModel.dart';
import 'movie/QueueMenu.dart';
import 'movie/LikedListMenu.dart';
import 'movie/FriendsLikedListMenu.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _database = await DatabaseGetter.instance.database;



  //Users: Hayley (H1), Karley (K1), Aliza (A1)
  //Movies: 2001, Spongebob, Howls moving castle

  //IF YOU ARE RUNNING FOR FIRST TIME:
  //1. COMMENT OUT THE RUN APP METHOD
  runApp(MyApp(_database));
  //2. UNCOMMENT LINES BELOW. RUN, WAIT FOR PRINT STATEMENTS, STOP, COMMENT LINES AGAIN
  // MainViewModel mvm = MainViewModel(_database);
  // await mvm.clearMovieTable();
  // await mvm.clearPersonalQueueTable();
  // print("Cleared t");
  // await mvm.addUser("Hayley", "H1");
  // await mvm.addUser("Karley", "K1");
  // await mvm.addUser("Aliza", "A1");
  // print("Added users ");
  // await mvm.addMovie("2001: A Space Odyssey","https://m.media-amazon.com/images/M/MV5BMmNlYzRiNDctZWNhMi00MzI4LThkZTctMTUzMmZkMmFmNThmXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX67_CR0,0,67,98_AL_.jpg","G",8.3,"149 min","Adventure, Sci-Fi", "After discovering a mysterious artifact buried beneath the Lunar surface, mankind sets off on a quest to find its origins with help from intelligent supercomputer H.A.L. 9000.");
  // await mvm.addMovie("Howl's Moving Castle","https://i.pinimg.com/originals/7e/1a/a0/7e1aa0c598af420ad528a3fd8dabdc1a.jpg","PG",8.2,"119 min","Animation, Adventure, Family", "When an unconfident young woman is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking castle.");
  // await mvm.addMovie("The SpongeBob Movie: Sponge out of Water", "https://m.media-amazon.com/images/I/91dT8udHqNL._SL1500_.jpg", "PG", 10, "Never", "Animation, Family", "IDK Stupid Spongebob");
  // print("Added movies");


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
    LikedListMenu().returnMyList(),
    QueueMenu(db),
    FriendsLikedListMenu().returnFriendsList()
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
            label: 'Friend1 Liked List',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
