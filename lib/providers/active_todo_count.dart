import 'package:equatable/equatable.dart';
import 'package:todo_provider/models/todo_model.dart';

import 'package:todo_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount {
  final TodoList todos;
  ActiveTodoCount({
    required this.todos,
  });

  ActiveTodoCountState get state => ActiveTodoCountState(
        activeTodoCount: todos.state.todos
            .where((Todo todo) => !todo.completed)
            .toList()
            .length,
      );
}
