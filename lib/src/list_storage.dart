import 'package:hive/hive.dart';
import 'package:just_do/src/todo.dart';

class ListStorage {
  static const _boxName = 'just_do_box';
  static const _listKeyName = 'todo_list';

  Future<List<Todo>> query() async {
    final _box = await Hive.openBox(_boxName);
    final list = _box.get(_listKeyName);
    if (list != null && list is TodoList) {
      return list.todos;
    }
    return<Todo>[];
  }

  void save(List<Todo> todos) async {
    final _box = await Hive.openBox(_boxName);
    _box.put(_listKeyName, TodoList(todos));
  }
}