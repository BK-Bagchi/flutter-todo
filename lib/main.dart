import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class Todo {
  String text;
  bool isCompleted;

  Todo(this.text, this.isCompleted);
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> todos = [];
  TextEditingController _textEditingController = TextEditingController();

  void addTodo() {
    final text = _textEditingController.text;
    if (text.isNotEmpty) {
      setState(() {
        todos.add(Todo(text, false));
        _textEditingController.clear();
      });
    }
  }

  void toggleTodoStatus(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }

  void editTodo(int index) {
    final TextEditingController _editTextController =
        TextEditingController(text: todos[index].text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Todo"),
          content: TextField(
            controller: _editTextController,
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  todos[index].text = _editTextController.text;
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Enter a task',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addTodo,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      todos[index].text,
                      style: TextStyle(
                        decoration: todos[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editTodo(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTodo(index),
                        ),
                      ],
                    ),
                    onTap: () => toggleTodoStatus(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
