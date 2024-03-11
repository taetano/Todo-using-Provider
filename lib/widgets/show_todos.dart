import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/providers.dart';
import 'package:todo_provider/widgets/todo_item.dart';

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
    final todos = context.watch<FilteredTodosState>().filteredTodos;

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
