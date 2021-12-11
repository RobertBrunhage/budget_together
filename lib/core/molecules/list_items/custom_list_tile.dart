import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../household/controllers/household_controller.dart';
import '../../../household/models/expense/expense.dart';

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
      onLongPress: () => ref.read(householdControllerProvider.notifier).deleteExpense(expense.id),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Expense>('expense', expense));
  }
}
