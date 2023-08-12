import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/all_providers.dart';
import '../models/todo_model.dart';

// ignore: must_be_immutable
class TodoListItemWidget extends ConsumerStatefulWidget {
  TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

bool isEditing = false;
late TextEditingController? controller;
bool autoFocus = false;

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    TodoModel currentTodo = ref.watch(currentTodoProvider);
    return ListTile(
      leading: Checkbox(
        value: currentTodo.completed,
        onChanged: (value) {
          ref
              .read(todoListProvider.notifier)
              .toogleTodoStatus(id: currentTodo.id);
        },
      ),
      title: isEditing
          ? TextField(
              autofocus: autoFocus,
              controller: controller,
              onTapOutside: (event) {
                setState(() {
                  autoFocus = false;
                  isEditing = false;
                });
              },
              onSubmitted: (value) {
                ref
                    .read(todoListProvider.notifier)
                    .editTodo(id: currentTodo.id, description: value);
                setState(() {
                  autoFocus = false;
                  isEditing = false;
                });
              },
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  autoFocus = true;
                  controller!.text = currentTodo.description;
                  isEditing = true;
                });
              },
              child: Text(currentTodo.description)),
    );
  }
}
