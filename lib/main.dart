import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:moovi/friends/FriendsListMenu.dart';
import 'database/DatabaseGetter.dart';
import 'database/mainViewModel.dart';
import 'database/userEntity.dart';
import 'profile/UserProfile.dart';
import 'movie/QueueMenu.dart';
import 'package:moovi/Theme/ThemeData.dart';
import 'package:moovi/Theme/splash.dart';



void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  final _database = await DatabaseGetter.instance.database;
  final MainViewModel mvm = MainViewModel(_database);

  MyApp.db = _database;
  MyApp.mvm = mvm;

  runApp(MaterialApp(home: Splash(),
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.darkTheme,

  )
  );

}

class MyApp extends StatelessWidget{
  static late FloorDatabase db;
  static late MainViewModel mvm;
  static late UserEntity user;
  static List<String> genres = [""];

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOOVI',
      theme: CustomTheme.darkTheme,
      home: MenusStatefulWidget(1),
    );
  }
}

class MenusStatefulWidget extends StatefulWidget {
  final index;
  const MenusStatefulWidget(this.index, {Key? key}) : super(key: key);

  @override
  State<MenusStatefulWidget> createState() => _MenusStatefulWidgetState(index);
}

class _MenusStatefulWidgetState extends State<MenusStatefulWidget> {
  bool actionChecked = false; bool adventureChecked = false; bool comedyChecked = false; bool crimeChecked = false; bool dramaChecked = false;
  bool fantasyChecked = false; bool horrorChecked = false; bool romanceChecked = false; bool scifiChecked = false; bool thrillerChecked = false;
  int _selectedIndex = 1;
  late List<Widget> _widgetOptions;

  _MenusStatefulWidgetState(index) {
    _selectedIndex = index;
  _widgetOptions = <Widget>[ //List of widgets for the screen
    LikedList(),
    QueueMenu(),
    FriendsListMenu()
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
      drawer:  Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 120,
            child:  DrawerHeader(child:
            Text("Filter by:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)
            ),

            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          CheckboxListTile(
              title: Text("Action", style: TextStyle(fontSize: 20),),
            value: actionChecked,
              onChanged: (value){
                setState(() {
                  actionChecked = value!;
                  setGenres(value, "Action");
                });
              },
          ),

          CheckboxListTile(
            title: Text("Adventure", style: TextStyle(fontSize: 20),),
            value: adventureChecked,
            onChanged: (value){
              setState(() {
                adventureChecked = value!;
                setGenres(value, "Adventure");
              });
            },
          ),

          CheckboxListTile(
            title: Text("Comedy", style: TextStyle(fontSize: 20),),
            value: comedyChecked,
            onChanged: (value){
              setState(() {
                comedyChecked = value!;
                setGenres(value, "Comedy");
              });
            },
          ),

          CheckboxListTile(
            title: Text("Crime", style: TextStyle(fontSize: 20),),
            value: crimeChecked,
            onChanged: (value){
              setState(() {
                crimeChecked = value!;
                setGenres(value, "Crime");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Drama", style: TextStyle(fontSize: 20),),
            value: dramaChecked,
            onChanged: (value){
              setState(() {
                dramaChecked = value!;
                setGenres(value, "Drama");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Fantasy", style: TextStyle(fontSize: 20),),
            value: fantasyChecked,
            onChanged: (value){
              setState(() {
                fantasyChecked = value!;
                setGenres(value, "Fantasy");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Horror", style: TextStyle(fontSize: 20),),
            value: horrorChecked,
            onChanged: (value){
              setState(() {
                horrorChecked = value!;
                setGenres(value, "Horror");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Romance", style: TextStyle(fontSize: 20),),
            value: romanceChecked,
            onChanged: (value){
              setState(() {
                romanceChecked = value!;
                setGenres(value, "Romance");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Sci-Fi", style: TextStyle(fontSize: 20),),
            value: scifiChecked,
            onChanged: (value){
              setState(() {
                scifiChecked = value!;
                setGenres(value, "Sci-Fi");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Thriller", style: TextStyle(fontSize: 20),),
            value: thrillerChecked,
            onChanged: (value){
              setState(() {
                thrillerChecked = value!;
                setGenres(value, "Thriller");
              });
            },
          ),
        ])
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff202428),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              size: 30,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house,
              size: 30,
            ),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              size: 30,
            ),
            label: "Friends"
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xfff5df50),
        onTap: _onItemTapped,
      ),

    );

  }

  Widget showIndicator(bool show) {
    return show ? Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Icon(Icons.brightness_1, size: 10, color: Colors.orange),
    )
        : SizedBox();
  }

  void setGenres(value, text){
    final genres = MyApp.genres;
    if(value && !genres.contains(text)){
      if(genres[0] == ""){
        genres[0] = text;
      } else {
        genres.add(text);
      }
    } else if(!value){ //value is false
      genres.remove(text);
      if(genres.length == 0){
        genres.add("");
      }
    }
    // print(MenusStatefulWidget.genres[0]);
  }
}


