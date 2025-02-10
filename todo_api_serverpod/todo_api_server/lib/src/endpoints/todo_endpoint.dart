import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

List<Todo> _todos = [];

class TodoEndpoint extends Endpoint {
  Future<List<Todo>> getAllTodos(Session session) async {
    return _todos;
  }

  Future<void> addTodo(Session session, {required String text}) async {
    _todos.add(Todo(id: _todos.length, text: text, done: false));
  }

  Future<void> updateTodo(Session session, {required Todo todo, required int index}) async {
    _todos[index] = todo;
  }

  Future<void> deleteTodo(Session session, {required int index}) async {
    _todos.removeAt(index);
  }
}
