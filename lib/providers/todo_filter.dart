import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import 'package:todo_provider/models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter _filter;
  TodoFilterState({
    required filter,
  }) : _filter = filter;

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  Filter get filter => _filter;

  @override
  List<Object> get props => [_filter];

  @override
  String toString() => 'TodoFilterState(filter: $_filter)';

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this._filter,
    );
  }
}

class TodoFilter extends StateNotifier<TodoFilterState> {
  TodoFilter() : super(TodoFilterState.initial());

  void changeFilter(Filter newFilter) {
    state = state.copyWith(filter: newFilter);
  }
}
