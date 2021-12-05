import 'package:budget_together/household/controllers/household_controller.dart';
import 'package:budget_together/household/models/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomListTile extends ConsumerWidget {
  const CustomListTile({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(expense.category.name),
      subtitle: Text(expense.dateFormatted()),
      trailing: Text('${expense.amount} :-'),
      onLongPress: () => ref
          .read(householdControllerProvider.notifier)
          .deleteExpense(expense.id),
    );
  }
}
