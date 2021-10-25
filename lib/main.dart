import 'package:flutter/material.dart';
import 'QueueMenu.dart';
import "package:flutter/material.dart";
import "yourLikedList.dart";
import "friendsLikedList.dart";

void main(){
   runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOVI',
      home: MyStatefulWidget(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: QueueMenu(title: 'Flutter Demo Home Page'))
    );
  }
}


/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[ //List of widgets for the screen
       yourLikedList().returnMyList(), 
          TextButton(
              style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.blue,
              textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text('Gradient'),
              ) ,
        friendsLikedList().returnFriendsList()  
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
            label: 'Your Liked List',
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


