import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Taskly extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<Taskly> {
  String? _newTaskContent;
  late BuildContext _buildContext;
  late double _deviceHeight;
  late double _deviceWidth;

  Box? _box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasky",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
        toolbarHeight: _deviceHeight * 0.10,
      ),
      body: _taskView(),
      floatingActionButton: _AddTaskButton(context),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox("task"),
      builder: (BuildContext _context, AsyncSnapshot _snapShot) {
        if (_snapShot.connectionState == ConnectionState.done) {
          _box = _snapShot.data;
          return _TaskList();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _TaskList() {
    return ListView(children: [_ListTiles()]);
  }

  Widget _ListTiles() {
    List _task = _box!.values.toList();
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
                  setState(() {
                    _newTaskContent = _value;
                  });
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
}
