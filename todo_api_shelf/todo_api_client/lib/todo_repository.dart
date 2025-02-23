import 'package:dio/dio.dart';
import 'package:todo_api_client/data/todo.dart';

class TodoRepository {
  final dio = Dio();

  Future<List<Todo>> getTodos() async {
    // GET
    final response = await dio.get('http://localhost:8080/todos');
    Map<String, dynamic> decodedResponse = response.data;
    final List<Todo> todos = decodedResponse['todos']
        .map(
          (data) => Todo.fromJson(data),
        )
        .toList()
        .cast<Todo>() as List<Todo>;
    return todos;
  }

  Future<void> addTodo(String text) async {
    // POST
    final data = {'text': text};
    await dio.post('http://localhost:8080/todos', data: data);
  }

  Future<void> putTodo(Todo todo) async {
    // PUT
    final data = {'text': todo.text, 'done': todo.done};
    final id = todo.id;
    await dio.put('http://localhost:8080/todos/$id', data: data);
  }

  Future<void> deleteTodo(int id) async {
    // DELETE
    await dio.delete('http://localhost:8080/todos/$id');
  }
}
