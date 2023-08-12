import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager(List<TodoModel> list) : super(list);
  void addTodo({required String description}) {
    state = [
      ...state,
      TodoModel(id: const Uuid().v4(), description: description)
    ];
  }

  void toogleTodoStatus({required String id}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed)
        else
          todo
    ];
  }

  void editTodo({required String id, required String description}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id, description: description, completed: todo.completed)
        else
          todo
    ];
  }

  void removeTodo({required String id}) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void updateTodo({required String id, required String description}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id, description: description, completed: todo.completed)
        else
          todo
    ];
  }
}
