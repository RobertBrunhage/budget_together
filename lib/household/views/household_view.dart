import 'dart:developer';

import 'package:budget_together/core/molecules/list_items/custom_list_tile.dart';
import 'package:budget_together/household/models/household/household.dart';
import 'package:budget_together/household/widgets/custom_app_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/login.dart';
import '../controllers/household_controller.dart';

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
      body: ref.watch(householdControllerProvider).household.when(
            data: (household) {
              return _Body(household: household);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => const Center(child: Text('error')),
          ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Budget together'),
            ),
            ListTile(
              title: const Text('Invite'),
              onTap: () {
                context.go('/household/invite');
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              onTap: () {
                _signOut();
              },
            ),
          ],
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

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
    required this.household,
  }) : super(key: key);

  final Household? household;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async =>
          ref.read(householdControllerProvider.notifier).fetchExpenses(),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomAppBarDelegate(
              expandedHeight: 170,
              statusbarHeight: MediaQuery.of(context).padding.top,
              ref: ref,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(child: _SpentThisMonth(household: household)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Utgifter'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final expense = household!.expenses[index];
              return CustomListTile(expense: expense);
            }, childCount: household?.expenses.length ?? 0),
          ),
        ],
      ),
    );
  }
}

class _SpentThisMonth extends StatelessWidget {
  const _SpentThisMonth({
    Key? key,
    required this.household,
  }) : super(key: key);

  final Household? household;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Spenderat denna månaden',
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          '${household?.spentThisMonth} kr',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
