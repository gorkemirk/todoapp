import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/todolist_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

enum TodoListFilter { all, active, completed }

final todoListFilterProvider = StateProvider<TodoListFilter>((ref) {
  return TodoListFilter.all;
});
final filteredTodoListProvider = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilterProvider);
  final todoList = ref.watch(todoListProvider);
  switch (filter) {
    case TodoListFilter.active:
      return todoList.where((todo) => todo.completed == false).toList();
    case TodoListFilter.completed:
      return todoList.where((todo) => todo.completed == true).toList();
    default:
      return todoList;
  }
});

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Spora Git'),
    TodoModel(id: const Uuid().v4(), description: 'Alışveriş yap'),
    TodoModel(id: const Uuid().v4(), description: 'Ders Çalış'),
  ]);
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});

final unCompletedTodoCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
final completedTodoCount = Provider<List<TodoModel>>((ref) {
  return ref
      .watch(todoListProvider)
      .where((todo) => todo.completed == true)
      .toList();
});
final activeTodoCount = Provider<List<TodoModel>>((ref) {
  return ref
      .watch(todoListProvider)
      .where((todo) => todo.completed == false)
      .toList();
});
final allCompletedTodoCount = Provider<List<TodoModel>>((ref) {
  return ref.watch(todoListProvider);
});
