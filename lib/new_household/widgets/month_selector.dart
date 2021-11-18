import 'package:budget_together/new_household/controllers/household_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MonthSelectorList extends ConsumerStatefulWidget {
  const MonthSelectorList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MonthSelectorList> createState() => _MonthSelectorListState();
}

class _MonthSelectorListState extends ConsumerState<MonthSelectorList> {
  final _controller = ScrollController();
  final dateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (dateNow.month > 7) {
        _controller.animateTo(dateNow.month * 20,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final date = DateTime(dateNow.year, index + 1);
          return MonthItem(month: date.month);
        },
      ),
    );
  }
}

class MonthItem extends ConsumerWidget {
  const MonthItem({
    Key? key,
    required this.month,
  }) : super(key: key);

  final int month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () =>
          ref.read(householdControllerProvider.notifier).setMonth(month),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          DateFormat.MMM().format(DateTime(0, month)),
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: isSelectedWeight(ref),
              ),
        ),
      ),
    );
  }

  FontWeight isSelectedWeight(WidgetRef ref) {
    if (ref.watch(householdControllerProvider).selectedMonth == month) {
      return FontWeight.bold;
    }
    return FontWeight.normal;
  }
}
