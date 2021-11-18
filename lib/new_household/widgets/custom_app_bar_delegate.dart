import 'package:budget_together/new_household/controllers/household_controller.dart';
import 'package:budget_together/new_household/models/household/household.dart';
import 'package:budget_together/new_household/widgets/month_selector.dart';
import 'package:budget_together/new_household/widgets/year_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          onPressed: () => context.go('/household/add-expense'),
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}