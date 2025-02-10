import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_api_shelf/todo.dart';

List<Todo> todos = [Todo(id: 0, text: 'text', done: false)];

Response listTodosHandler(Request req) => Response(
      HttpStatus.ok,
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
  if (data['text'] == null) {
    return Response(HttpStatus.badRequest);
  }

  todos.add(Todo(id: todos.length, text: data['text'], done: false));
  return Response(HttpStatus.created);
}

Future<Response> putTodoHandler(Request req) async {
  final id = req.params['id'];
  if (id == null) {
    return Response(HttpStatus.badRequest);
  }
  final idInt = int.parse(id);

  final body = await req.readAsString();
  final Map<String, dynamic> data = jsonDecode(body);

  final index = todos.indexWhere((todo) => todo.id == idInt);
  if (index == -1) {
    return Response(HttpStatus.badRequest);
  }

  if ((data['text'] == null) || (data['done'] == null)) {
    return Response(HttpStatus.badRequest);
  }

  todos.fillRange(index, index + 1, Todo(id: idInt, text: data['text'], done: !data['done']));
  return Response(HttpStatus.ok);
}

Response deleteTodoHandler(Request req) {
  final id = req.params['id'];
  if (id == null) {
    return Response(HttpStatus.badRequest);
  }
  final idInt = int.parse(id);
  final index = todos.indexWhere((todo) => todo.id == idInt);
  if (index == -1) {
    return Response(HttpStatus.badRequest);
  }
  todos.removeWhere((todo) => todo.id == idInt);
  return Response(200);
}

const _jsonHeaders = {
  'content-type': 'application/json',
};

String _jsonEncode(Object? data) => const JsonEncoder.withIndent(' ').convert(data);
