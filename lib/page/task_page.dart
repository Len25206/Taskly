import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

String? _newTaskContent;
late BuildContext _buildContext;
late double _deviceHeight;
late double _deviceWidth;

class Taskly extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<Taskly> {
  @override
  Widget build(BuildContext context) {
    print("the new task is $_newTaskContent");
    _buildContext = context;
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

Widget _taskView() {
  Hive.openBox("task");
  return _TaskList();
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
    onPressed: _displayTask,
    backgroundColor: Colors.pink,
    child: const Icon(Icons.add),
  );
}

void _displayTask() {
  showDialog(
    context: _buildContext,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text('Add Task'),
            content: TextField(
              onSubmitted: (_value) {
                if (_newTaskContent != null) {
                  _newTaskContent = "";
                }
                _newTaskContent = _value;
                Navigator.of(context).pop();
              },
              onChanged: (_value) {
                setState(() {});
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("close"),
              ),
            ],
          );
        },
      );
    },
  );
}
