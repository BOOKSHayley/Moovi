import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget{

  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Card> cardList = [
      new Card(child: ListTile(title: Text("movie1"))),
      new Card(child: ListTile(title: Text("movie2"))),
      new Card(child: ListTile(title: Text("movie3"))),
    ];
    // return ListView(
    //   children: cardList,
    // );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.deepPurple,
                  ],
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    'username',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.topRight,
                      // child: ConstrainedBox(
                      //     constraints: BoxConstraints.tightFor(width: 100, height: 100),
                      //   child: ElevatedButton.icon(
                      //     style: ElevatedButton.styleFrom(
                      //         shape: CircleBorder(),
                      //         primary: Colors.deepPurple
                      //     ),
                      //     icon: Icon(
                      //       Icons.more_vert,
                      //       color: Colors.white,
                      //     ),
                      //     label: Text('Elevated Button'),
                      //     onPressed: () {}
                      child: SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("First"),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text("Second"),
                              value: 2,
                            )
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                          child: Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colors.white
                          ),
                        ),
                      ),
                    )
                )

              ]

            )
          ),
          Expanded(
            child: ListView(
              children: cardList
            )
          ),

        Padding(
        padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topRight,
              child: SizedBox(
                height: 80.0,
                width: 80.0,
                child: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("First"),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text("Second"),
                        value: 2,
                      )
                    ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Icon(
                      Icons.more_vert,
                      size: 70,
                      color: Colors.white
                  ),
                ),
              ),
            )
        )
        ],
      ),
    );

  }
}