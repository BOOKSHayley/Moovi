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
      child: Queue(key: queueKey),
    );
  }
}