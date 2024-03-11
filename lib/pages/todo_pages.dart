import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/providers.dart';
import 'package:todo_provider/widgets/create_todo.dart';
import 'package:todo_provider/widgets/search_and_filter_todo.dart';
import 'package:todo_provider/widgets/todo_header.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                SizedBox(height: 20.0),
                SearchAndFilterTodo(),
                ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  Widget showBackground(int direction) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodos>().state.filteredTodos;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_) {
            context.read<TodoList>().removeTodo(todos[index]);
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false, // * Dialog 외부를 클릭해도 Dialog가 사라지지 않는다.
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you really want to delete?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('NO'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('YES'),
                    ),
                  ],
                );
              },
            );
          },
          child: TodoItem(
            todo: todos[index],
          ),
        );
      },
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool _error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? 'Value can not be empty' : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () => {
                        setState(() {
                          _error =
                              textController.text.trim().isEmpty ? true : false;

                          if (!_error) {
                            context
                                .read<TodoList>()
                                .editTodo(widget.todo.id, textController.text);
                            Navigator.of(context).pop();
                          }
                        })
                      },
                      child: Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          if (checked != null) {
            context.read<TodoList>().toggleCompleted(widget.todo.id);
          }
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
