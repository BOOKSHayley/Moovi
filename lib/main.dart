import 'package:flutter/material.dart';
import 'movie/QueueMenu.dart';
import 'movie/LikedListMenu.dart';
import 'movie/FriendsLikedListMenu.dart';

void main(){
   runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOVI',
      home: MenusStatefulWidget(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MenusStatefulWidget extends StatefulWidget {
  const MenusStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MenusStatefulWidget> createState() => _MenusStatefulWidgetState();
}

class _MenusStatefulWidgetState extends State<MenusStatefulWidget>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[ //List of widgets for the screen
    LikedListMenu().returnMyList(),
    QueueMenu(),
    FriendsLikedListMenu().returnFriendsList()
  ];

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

// import "package:flutter/material.dart";

// void main() {
//   runApp(MyApp());
// } //void main() => runApp(MyApp());

// //Also a widget
// class MyApp extends StatefulWidget {
//   @override
//     State<StatefulWidget> createState(){
//        return _MyAppState();
//     }
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           //Widget that creates a new page in your app (white background)
//           appBar: AppBar(
//             //ToolBar at the top of the screen
//             title: Text('EasyList'), //Built into Flutter
//           ),
//           body: Column(
//             children: [
//               Card(
//                 child: Column(
//                   children: <Widget>[
//                     Image.asset('assets/Donuts.jpg'),
//                     Text('Donuts'),
//                     Image.asset('assets/Food.jpg'),
//                     Text('Veggies')
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }


