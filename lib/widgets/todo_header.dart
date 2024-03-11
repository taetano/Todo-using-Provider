import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/active_todo_count.dart';

class TodoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Todo',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          '${context.watch<ActiveTodoCountState>().activeTodoCount} items left',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
