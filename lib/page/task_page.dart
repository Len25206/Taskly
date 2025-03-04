import 'package:flutter/material.dart';

class Taskly extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<Taskly> {
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        toolbarHeight: _deviceHeight * 0.10,
      ),
      body: _TaskList(),
      floatingActionButton: _AddTaskButton(context),
    );
  }
}

Widget _TaskList() {
  return ListView(children: [_ListTiles()]);
}

Widget _ListTiles() {
  return ListTile(
    title: Text(
      "HELLO",
      style: TextStyle(decoration: TextDecoration.lineThrough),
    ),
    hoverColor: Colors.amber,
    subtitle: Text(DateTime.now().toString()),
    trailing: Icon(Icons.check_box_outlined),
  );
}

Widget _AddTaskButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      _displayTask(context);
    },
    backgroundColor: Colors.pink,
    child: const Icon(Icons.add),
  );
}

void _displayTask(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Task'),
        content: Text('This is where you can add a task!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
