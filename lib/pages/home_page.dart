import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import '/util/dialog_box.dart';
import '/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box

  final _myBox = Hive.box('mybox');
  ToDoDatabse db = ToDoDatabse();

  @override
  void initState() {
// if this is the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller

  final _controller = TextEditingController();

  // List toDoList = [
  //   ["Make tutorial", false],
  //   ["Do exercise", false],
  // ];

  //checkbox was tapped
  void chckBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    _controller.text = '';
  }

  void createNewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.of(context).pop();
              _controller.text = '';
            });
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewtask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => chckBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
