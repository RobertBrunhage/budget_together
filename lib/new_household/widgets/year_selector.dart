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
          return YearItem(year: itemYear);
        },
      ),
    );
  }
}

class YearItem extends ConsumerWidget {
  const YearItem({
    Key? key,
    required this.year,
  }) : super(key: key);

  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(householdControllerProvider.notifier).setYear(year),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          year.toString(),
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: isSelectedWeight(ref),
              ),
        ),
      ),
    );
  }

  FontWeight isSelectedWeight(WidgetRef ref) {
    if (ref.watch(householdControllerProvider).selectedYear == year) {
      return FontWeight.bold;
    }
    return FontWeight.normal;
  }
}
