import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class TodoList {
  TodoList(this.todos);

  @HiveField(0)
  List<Todo> todos;
}

@HiveType(typeId: 0)
class Todo {
  Todo(this.content, this.date, this.tasks);

  @HiveField(0)
  String content;

  @HiveField(1)
  String date;

  @HiveField(2)
  List<Task> tasks;
}

@HiveType(typeId: 2)
class Task {
  Task(this.content, this.date);

  @HiveField(0)
  String content;

  @HiveField(1)
  String date;
}
