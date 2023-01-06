import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabse {
  List toDoList = [];
// reference the box

  final _myBox = Hive.box('mybox');

//run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make tutorial", false],
      ["Do exercise", false],
    ];
  }

// load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

//update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
