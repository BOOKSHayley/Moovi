import 'package:flutter/material.dart';
import 'Queue.dart';

class QueueMenu extends StatefulWidget {
  QueueMenu({Key? key, required this.title}) : super(key: key);

  final String title;

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
          Row(children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: Text("Like"),
                //color: Colors.greenAccent,
                onPressed: () {},

              ),
            ),

            Expanded(
              child: ElevatedButton(
                child: Text("Dislike"),
                //color: Colors.red,
                onPressed: () {},
              )
            )

          ])
        ],
      ),
    );
  }
}