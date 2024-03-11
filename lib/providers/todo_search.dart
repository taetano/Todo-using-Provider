import 'package:equatable/equatable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

/*
  * String type의 필드 하나만들 가지고 있지만 클래스로 상태를 만들어서 관리하는 이유.
    1. State 작성방법의 일관화, 모든 State를 동일한 형식으로 작성함으로 타인원의 코드를 알아보기 쉽다.
    2. Provider는 Widget Tree는 부모를 탐색하며 해당하는 Provider를 찾는다. 이때 primitive type 충돌을 피할 수 있다.  
*/
class TodoSearchState extends Equatable {
  final String searchTerm;
  TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() {
    return TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TodoSearchState(searchTerm: $searchTerm)';

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class TodoSearch extends StateNotifier<TodoSearchState> {
  TodoSearch() : super(TodoSearchState.initial());

  void setSearchTerm(String newSearchTerm) {
    state = state.copyWith(searchTerm: newSearchTerm);
  }
}
