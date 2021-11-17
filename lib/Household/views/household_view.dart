import 'dart:developer';

import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/controllers/household_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HouseholdView extends ConsumerStatefulWidget {
  const HouseholdView({Key? key}) : super(key: key);

  @override
  ConsumerState<HouseholdView> createState() => _HouseholdViewState();
}

class _HouseholdViewState extends ConsumerState<HouseholdView> {
  @override
  Widget build(BuildContext context) {
    ref.listen<HouseholdState>(householdControllerProvider, (previous, next) {
      if (next.household.value == null) {
        context.go('/household/create');
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _signOut,
            child: Text(
              'Sign out',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.go('/household/invite'),
            child: Text(
              'invite',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.read(householdControllerProvider.notifier).fetchExpenses(),
        child: Center(
          child: ref.watch(householdControllerProvider).household.when(
                data: (household) {
                  return Column(
                    children: [
                      Text(household?.name ?? ''),
                      Text(
                          '${household?.expenses.fold<double>(0, (previousValue, element) => previousValue + element.amount)} SEK'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: household?.expenses.length ?? 0,
                          itemBuilder: (context, index) {
                            final expense = household!.expenses[index];
                            return ListTile(
                              // TODO: Expense should be correct
                              title: Text('${expense.amount} SEK'),
                              subtitle: Text(expense.user.name),
                              trailing: Text(expense.category.name),
                              onLongPress: () => ref
                                  .read(householdControllerProvider.notifier)
                                  .deleteExpense(expense.id),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go('/household/add-expense'),
                        child: const Text('Add expense'),
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, s) => const Text('error'),
              ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();

    final error = response.error;
    if (error != null) {
      log(error.message);
      context.go('/login');
    }
  }
}
