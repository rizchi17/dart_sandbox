import 'package:flutter/material.dart';
import 'package:todo_api_client/controller/todo_controller.dart';
import 'package:todo_api_client/data/todo.dart';

class TodosListPage extends StatefulWidget {
  const TodosListPage({super.key, required this.title});

  final String title;

  @override
  State<TodosListPage> createState() => _TodosListPageState();
}

class _TodosListPageState extends State<TodosListPage> {
  List<Todo> _todos = [];
  final _textEditingController = TextEditingController();
  final controller = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _textEditingController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final List<Todo> latestTodos = await controller.fetchTodos();
                setState(() {
                  _todos = latestTodos;
                });
              },
              child: Icon(Icons.refresh),
            ),
            ElevatedButton(
              onPressed: () async {
                final List<Todo> latestTodos = await controller.addTodo(_textEditingController.text);
                _textEditingController.clear();
                setState(() {
                  _todos = latestTodos;
                });
              },
              child: Icon(Icons.add_box_rounded),
            ),
            ..._todos.map((todo) => Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final List<Todo> latestTodos = await controller.deleteTodo(todo);
                              setState(() {
                                _todos = latestTodos;
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                          Text(todo.text),
                        ],
                      ),
                      Checkbox(
                        value: todo.done,
                        onChanged: (value) async {
                          final List<Todo> latestTodos = await controller.changeDoneTodo(todo);
                          setState(() {
                            _todos = latestTodos;
                          });
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
