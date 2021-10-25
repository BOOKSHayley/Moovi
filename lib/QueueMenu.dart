import 'package:flutter/material.dart';
import 'Queue.dart';

class QueueMenu extends StatefulWidget {
  QueueMenu({Key? key, //required this.title}
  }) : super(key: key);

  //final String title;

  @override
  _QueueMenuState createState() => _QueueMenuState();
}

class _QueueMenuState extends State<QueueMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Queue(),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(children: <Widget>[
              Expanded(
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.thumb_down),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.thumb_up),
                  onPressed: () {},
                )
              )
            ]
          )
          )
        ],
      ),
    );
  }
}