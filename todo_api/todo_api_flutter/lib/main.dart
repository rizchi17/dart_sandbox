import 'package:todo_api_client/todo_api_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://$localhost:8080/')..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Serverpod Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String? _resultMessage;
  String? _errorMessage;
  List<Todo> _todo = [];
  final _textEditingController = TextEditingController();

  Future<void> _fetchTodos() async {
    try {
      final result = await client.todo.getAllTodos();
      _todo = result;
      setState(() {
        _errorMessage = null;
        _resultMessage = 'Todosが正常に取得されました';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> _addTodo() async {
    try {
      await client.todo.addTodo(text: _textEditingController.text);
      _textEditingController.clear();
      setState(() {
        _errorMessage = null;
        _resultMessage = 'Todosが正常に追加されました';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> _updateTodo(Todo todo, int index) async {
    try {
      final newTodo = todo.copyWith(done: !todo.done);
      await client.todo.updateTodo(todo: newTodo, index: index);
      setState(() {
        _errorMessage = null;
        _resultMessage = 'Todosが正常に完了されました';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> _deleteTodo(int index) async {
    try {
      await client.todo.deleteTodo(index: index);
      setState(() {
        _errorMessage = null;
        _resultMessage = 'Todosが削除に追加されました';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Todoを入力',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: _fetchTodos,
                child: const Text('Get Todos'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _addTodo();
                  await _fetchTodos();
                },
                child: const Text('Add Todo'),
              ),
            ),
            _ResultDisplay(
              resultMessage: _resultMessage,
              errorMessage: _errorMessage,
            ),
            Flexible(
              child: ListView(
                children: _todo.asMap().entries.map((entry) {
                  int index = entry.key;
                  Todo todo = entry.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await _deleteTodo(index);
                                await _fetchTodos();
                              },
                              icon: Icon(Icons.delete)),
                          Text(todo.text),
                        ],
                      ),
                      Checkbox(
                        value: todo.done,
                        onChanged: (value) async {
                          await _updateTodo(todo, index);
                          await _fetchTodos();
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _ResultDisplays shows the result of the call. Either the returned result from
// the `example.hello` endpoint method or an error message.
class _ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const _ResultDisplay({
    this.resultMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    if (errorMessage != null) {
      backgroundColor = Colors.red[300]!;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = Colors.green[300]!;
      text = resultMessage!;
    } else {
      backgroundColor = Colors.grey[300]!;
      text = 'No server response yet.';
    }

    return Container(
      height: 50,
      color: backgroundColor,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
