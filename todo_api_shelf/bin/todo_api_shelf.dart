import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:todo_api_shelf/todo_api_shelf.dart';

final _router = Router()
  // post
  ..post('/todos', postTodoHandler)
  ..get('/todos', listTodosHandler);
// put
// delete

void main(List<String> arguments) async {
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  var server = await shelf_io.serve(handler, 'localhost', 8080);
  server.autoCompress = true; // TODO: これ何？
  print('Serving at http://${server.address.host}:${server.port}');
}
