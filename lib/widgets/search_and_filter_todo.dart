import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/providers.dart';
import 'package:todo_provider/utils/debounce.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({super.key});
  final Debounce debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Search todos',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              debounce.run(() {
                context.read<TodoSearch>().setSearchTerm(newSearchTerm);
              });
            }
          },
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterButton(context, Filter.all),
            FilterButton(context, Filter.active),
            FilterButton(context, Filter.completed),
          ],
        )
      ],
    );
  }

  Widget FilterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilter>().changeFilter(filter);
      },
      child: Text(
        filter.name[0].toUpperCase() + filter.name.substring(1),
        style: TextStyle(color: textColor(context, filter)),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterState>().filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
