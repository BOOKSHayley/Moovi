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
                  onPressed: () {queueKey.currentState?.stackSwipe(true);},
                ),
              ),
              Expanded(
                child: Image.asset("assets/CuteYellowCow_transparent.png",
                height: 75,
                width: 75,
                ),
              ),
              Expanded(
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.thumb_up),
                  onPressed: () {queueKey.currentState?.stackSwipe(false);},
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