import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/providers.dart';

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
