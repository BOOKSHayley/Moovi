import 'package:flutter/material.dart';
import 'movie/QueueMenu.dart';
import 'movie/LikedListMenu.dart';
import 'movie/FriendsLikedListMenu.dart';

void main(){
   //runApp(const MyApp());
  runApp(MaterialApp(home:LoginPage()));
}

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign In"),
        ),
        body: Column(
            children: [
              TextField(
                  decoration: InputDecoration(
                    hintText: "Your username",
                    labelText: "Username",
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  SizedBox(
                    width: 190,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[800])),
                      child: Align(
                        alignment: Alignment.center,

                        child: Text(
                          "No Account? Sign up!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => AccountCreationPage()
                        ));
                        //todo: backend code here
                      },

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  SizedBox(
                  width: 190,
                  height: 50,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey[700])),
                    child: Align(
                      alignment: Alignment.center,

                      child: Text(
                        "Sign in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => MyApp()
                      ));
                      //todo: backend code here
                    },

                  ),
                ),
              ]
              )

            ]
        )
    );
  }

}

class AccountCreationPage extends StatelessWidget{
  const AccountCreationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Create Account"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Your Name",
              labelText: "Name",
              contentPadding: EdgeInsets.all(10),
            )
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Your username",
              labelText: "Username",
              contentPadding: EdgeInsets.all(10),
            )
          ),
          Padding(
              padding: EdgeInsets.all(10),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[800])),
              child: Align(
                alignment: Alignment.center,

                child: Text(
                  "Sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => LoginPage()
                ));
              },

            ),
          ),
        ]
      )
    );
  }

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
  int _selectedIndex = 1;
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


