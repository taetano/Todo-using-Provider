import 'package:flutter/material.dart';
import 'package:todo_provider/widgets/create_todo.dart';
import 'package:todo_provider/widgets/search_and_filter_todo.dart';
import 'package:todo_provider/widgets/show_todos.dart';
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
