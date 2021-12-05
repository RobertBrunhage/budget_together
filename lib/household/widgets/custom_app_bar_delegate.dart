import 'package:budget_together/core/organisms/add_expense_bottom_sheet.dart';
import 'package:budget_together/core/organisms/selectors/month_selector.dart';
import 'package:budget_together/core/organisms/selectors/year_selector.dart';
import 'package:budget_together/household/controllers/household_controller.dart';
import 'package:budget_together/household/models/household/household.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  CustomAppBarDelegate({
    required this.expandedHeight,
    required this.statusbarHeight,
    required this.ref,
  });
  final double expandedHeight;
  final double statusbarHeight;
  final WidgetRef ref;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final household = ref.watch(householdControllerProvider).household.value;
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ListView(
        primary: false,
        children: [
          _CustomAppBar(household: household),
          const YearSelectorList(),
          const MonthSelectorList(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + statusbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
    required this.household,
  }) : super(key: key);

  final Household? household;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu),
        ),
        Text(household?.name ?? ''),
        const Spacer(),
        IconButton(
          onPressed: () => openAddExpenseSheet(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  void openAddExpenseSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return const AddExpenseBottomSheet();
      },
    );
  }
}
