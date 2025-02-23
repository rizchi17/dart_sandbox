import 'package:todo_api_client/data/todo.dart';
import 'package:todo_api_client/todo_repository.dart';

class TodoController {
  final _repository = TodoRepository();

  Future<List<Todo>> fetchTodos() async {
    return _repository.getTodos();
  }

  Future<List<Todo>> addTodo(String text) async {
    await _repository.addTodo(text);
    return _repository.getTodos();
  }

  Future<List<Todo>> changeDoneTodo(Todo todo) async {
    final Todo changedTodo = todo.copyWith(done: !todo.done);
    await _repository.putTodo(changedTodo);
    return _repository.getTodos();
  }

  Future<List<Todo>> changeTodoText(Todo todo) async {
    // 今回は呼び出さないので省略
    return [];
  }

  Future<List<Todo>> deleteTodo(Todo todo) async {
    await _repository.deleteTodo(todo.id!);
    return _repository.getTodos();
  }
}
