import 'package:flutter/material.dart';
import 'package:moovi/database/database.dart';
import 'Queue.dart';

class QueueMenu extends StatefulWidget {
  final db;
  QueueMenu(this.db, {Key? key}) : super(key: key);

  //final String title;

  @override
  _QueueMenuState createState() => _QueueMenuState(db);
}

class _QueueMenuState extends State<QueueMenu> {
  final db;
  _QueueMenuState(this.db);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Queue(db),
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