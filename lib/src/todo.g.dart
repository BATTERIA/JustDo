// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoListAdapter extends TypeAdapter<TodoList> {
  @override
  final typeId = 1;

  @override
  TodoList read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoList(
      (fields[0] as List)?.cast<Todo>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.todos);
  }
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.date);
  }
}
