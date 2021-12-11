import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/organisms/add_expense_bottom_sheet.dart';
import '../../core/organisms/selectors/month_selector.dart';
import '../../core/organisms/selectors/year_selector.dart';
import '../controllers/household_controller.dart';
import '../models/household/household.dart';

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
    final BuildContext context,
    final double shrinkOffset,
    final bool overlapsContent,
  ) {
    final household = ref.watch(householdControllerProvider).household.value;
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
  bool shouldRebuild(final SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    final Key? key,
    required this.household,
  }) : super(key: key);

  final Household? household;

  @override
  Widget build(final BuildContext context) {
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

  void openAddExpenseSheet(final BuildContext context) {
    showModalBottomSheet<AddExpenseBottomSheet>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (final context) {
        return const AddExpenseBottomSheet();
      },
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Household?>('household', household));
  }
}
