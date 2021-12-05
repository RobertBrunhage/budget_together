import 'package:budget_together/core/atoms/buttons/year_toggle.dart';
import 'package:budget_together/new_household/controllers/household_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearSelectorList extends ConsumerWidget {
  const YearSelectorList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = DateTime.now();
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) {
          final itemYear = date.year - index;
          return YearItem(
            year: itemYear,
            onTap: () {
              ref.read(householdControllerProvider.notifier).setYear(itemYear);
              ref.read(householdControllerProvider.notifier).fetchExpenses();
            },
            isActive:
                ref.watch(householdControllerProvider).selectedYear == itemYear,
          );
        },
      ),
    );
  }
}
