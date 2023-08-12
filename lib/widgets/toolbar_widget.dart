import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('ToolBarWidget build');
    int todoCount = ref.watch(unCompletedTodoCount);
    var curretnFilter = TodoListFilter.all;
    Color changeTextColor(TodoListFilter filter) {
      return curretnFilter == filter ? Colors.amber : Colors.blue;
    }

    curretnFilter = ref.watch(todoListFilterProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            todoCount == 0
                ? "Bütün görevler tamamlandı"
                : '$todoCount görev tamamlanmadı',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
            flex: 1,
            child: TextButton(
                style: TextButton.styleFrom(
                    primary: changeTextColor(TodoListFilter.all)),
                onPressed: () {
                  ref.read(todoListFilterProvider.notifier).state =
                      TodoListFilter.all;
                },
                child: const Text('All'))),
        Expanded(
            flex: 1,
            child: TextButton(
                style: TextButton.styleFrom(
                    primary: changeTextColor(TodoListFilter.active)),
                onPressed: () {
                  ref.read(todoListFilterProvider.notifier).state =
                      TodoListFilter.active;
                },
                child: const Text('Active'))),
        Expanded(
            flex: 1,
            child: TextButton(
                style: TextButton.styleFrom(
                    primary: changeTextColor(TodoListFilter.completed)),
                onPressed: () {
                  ref.read(todoListFilterProvider.notifier).state =
                      TodoListFilter.completed;
                },
                child: const Text(
                  'Completed',
                  overflow: TextOverflow.ellipsis,
                ))),
      ],
    );
  }
}
