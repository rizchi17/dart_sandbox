import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:todo_api_shelf/todo.dart';

List<Todo> todos = [Todo(text: 'text', done: false)];

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

Response postTodoHandler(Request req) {
  todos.add(Todo(text: 'new', done: false));
  return Response.ok('post!');
}

const _jsonHeaders = {
  'content-type': 'application/json',
};

String _jsonEncode(Object? data) => const JsonEncoder.withIndent(' ').convert(data);
