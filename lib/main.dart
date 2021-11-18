import 'package:flutter/material.dart';
import 'package:moovi/profile/FriendsListMenu.dart';
import 'accounts/login.dart';
import 'database/DatabaseGetter.dart';
import 'database/mainViewModel.dart';
import 'profile/UserProfile.dart';
import 'movie/QueueMenu.dart';
import 'package:moovi/Theme/ThemeData.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _database = await DatabaseGetter.instance.database;
  final MainViewModel mvm = MainViewModel(_database);

  runApp(MaterialApp(home: LoginPage(_database, mvm),
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.darkTheme,
  )
  );

}

class MyApp extends StatelessWidget{
  final db;
  const MyApp(this.db, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOOVI',
      theme: CustomTheme.darkTheme,
      home: MenusStatefulWidget(db),
    );
  }
}

class MenusStatefulWidget extends StatefulWidget {
  static List<String> genres = [""];
  final db;
  const MenusStatefulWidget(this.db, {Key? key}) : super(key: key);

  @override
  State<MenusStatefulWidget> createState() => _MenusStatefulWidgetState(db);
}

class _MenusStatefulWidgetState extends State<MenusStatefulWidget> {
  final db;
  bool actionChecked = false; bool adventureChecked = false; bool comedyChecked = false; bool crimeChecked = false; bool dramaChecked = false;
  bool fantasyChecked = false; bool horrorChecked = false; bool romanceChecked = false; bool scifiChecked = false; bool thrillerChecked = false;
  int _selectedIndex = 1;
  late List<Widget> _widgetOptions;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
      drawer:  Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child:  DrawerHeader(child:
            Text("Filter by:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)
            )
            ),
          ),
          CheckboxListTile(
              title: Text("Action"),
            value: actionChecked,
              onChanged: (value){
                setState(() {
                  actionChecked = value!;
                  setGenres(value, "Action");
                });
              },
          ),

          CheckboxListTile(
            title: Text("Adventure"),
            value: adventureChecked,
            onChanged: (value){
              setState(() {
                adventureChecked = value!;
                setGenres(value, "Adventure");
              });
            },
          ),

          CheckboxListTile(
            title: Text("Comedy"),
            value: comedyChecked,
            onChanged: (value){
              setState(() {
                comedyChecked = value!;
                setGenres(value, "Comedy");
              });
            },
          ),

          CheckboxListTile(
            title: Text("Crime"),
            value: crimeChecked,
            onChanged: (value){
              setState(() {
                crimeChecked = value!;
                setGenres(value, "Crime");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Drama"),
            value: dramaChecked,
            onChanged: (value){
              setState(() {
                dramaChecked = value!;
                setGenres(value, "Drama");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Fantasy"),
            value: fantasyChecked,
            onChanged: (value){
              setState(() {
                fantasyChecked = value!;
                setGenres(value, "Fantasy");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Horror"),
            value: horrorChecked,
            onChanged: (value){
              setState(() {
                horrorChecked = value!;
                setGenres(value, "Horror");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Romance"),
            value: romanceChecked,
            onChanged: (value){
              setState(() {
                romanceChecked = value!;
                setGenres(value, "Romance");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Sci-Fi"),
            value: scifiChecked,
            onChanged: (value){
              setState(() {
                scifiChecked = value!;
                setGenres(value, "Sci-Fi");
              });
            },
          ),

          CheckboxListTile(
              title: Text("Thriller"),
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
        backgroundColor: const Color(0xff2a3038),
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
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
        selectedItemColor: Colors.yellow,
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
    if(value && !MenusStatefulWidget.genres.contains(text)){
      if(MenusStatefulWidget.genres[0] == ""){
        MenusStatefulWidget.genres[0] = text;
      } else {
        MenusStatefulWidget.genres.add(text);
      }
    } else if(!value){ //value is false
      MenusStatefulWidget.genres.remove(text);
      if(MenusStatefulWidget.genres.length == 0){
        MenusStatefulWidget.genres.add("");
      }
    }
    // print(MenusStatefulWidget.genres[0]);
  }
}


