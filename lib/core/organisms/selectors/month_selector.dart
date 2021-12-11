import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../household/controllers/household_controller.dart';
import '../../atoms/buttons/month_toggle.dart';

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
        _controller.animateTo(dateNow.month * 20, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final date = DateTime(dateNow.year, index + 1);
          return MonthToggle(
            month: date.month,
            onTap: () {
              ref.read(householdControllerProvider.notifier).setMonth(date.month);
              ref.read(householdControllerProvider.notifier).fetchExpenses();
            },
            isActive: ref.watch(householdControllerProvider).selectedMonth == date.month,
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('dateNow', dateNow));
  }
}
