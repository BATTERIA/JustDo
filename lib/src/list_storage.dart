import 'dart:io';

import 'package:hive/hive.dart';
import 'package:just_do/src/todo.dart';
import 'package:path_provider/path_provider.dart';

class ListStorage {
  static const _boxName = 'just_do_box';
  static const _listKeyName = 'todo_list';

  Future<List<Todo>> query() async {
    var path = StringBuffer();
    if (Platform.isIOS || Platform.isAndroid) {
      path.write((await getTemporaryDirectory()).path);
      path.write('/');
    }
    path.write('just_do_db');
    Hive.init(path.toString());
    Hive.registerAdapter(TodoListAdapter());
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(TaskAdapter());

    final _box = await Hive.openBox(_boxName);
    final list = _box.get(_listKeyName);
    if (list != null && list is TodoList) {
      return list.todos;
    }
    return <Todo>[];
  }

  void save(List<Todo> todos) async {
    final _box = await Hive.openBox(_boxName);
    _box.put(_listKeyName, TodoList(todos));
  }
}
