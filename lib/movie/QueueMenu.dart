import 'package:flutter/material.dart';
import 'Queue.dart';

class QueueMenu extends StatefulWidget {
  QueueMenu({Key? key}) : super(key: key);

  @override
  _QueueMenuState createState() => _QueueMenuState();
}

class _QueueMenuState extends State<QueueMenu> {
  final queueKey = GlobalKey<QueueState>();
  _QueueMenuState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Queue(key: queueKey),
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
                child: Image.asset("assets/CuteCow_transparent.png",
                height: 65,
                width: 65,
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