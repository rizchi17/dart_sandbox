import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_api_shelf/todo.dart';

List<Todo> todos = [Todo(id: 0, text: 'text', done: false)];

Response listTodosHandler(Request req) => Response(
      200,
      headers: {
        ..._jsonHeaders,
        'Cache-Control': 'no-store',
      },
      body: _jsonEncode(
        {
          'todos': todos,
        },
      ),
    );

Future<Response> postTodoHandler(Request req) async {
  final body = await req.readAsString();
  final Map<String, dynamic> data = jsonDecode(body);
  // TODO: dataが期待するデータの形式でなければエラーを返す

  todos.add(Todo(id: todos.length, text: data['text'], done: false));

  return Response(201);
}

Future<Response> putTodoHandler(Request req) async {
  final id = req.params['id'];
  if (id == null) {
    return Response(400);
  }
  final idInt = int.parse(id);
  final body = await req.readAsString();
  final Map<String, dynamic> data = jsonDecode(body);
  Todo todo = todos.firstWhere((todo) => todo.id == data['id']);
  if (todo.id == -1) {
    return Response(400);
  }
  todos.fillRange(idInt, idInt + 1, Todo(id: idInt, text: data['text'], done: !data['done']));
  return Response(200);
}

Future<Response> deleteTodoHandler(Request req) async {
  final id = req.params['id'];
  if (id == null) {
    return Response(400);
  }
  // TODO: dataが期待するデータの形式でなければエラーを返す
  todos.removeWhere((todo) => todo.id == int.parse(id));
  return Response(200);
}

const _jsonHeaders = {
  'content-type': 'application/json',
};

String _jsonEncode(Object? data) => const JsonEncoder.withIndent(' ').convert(data);
