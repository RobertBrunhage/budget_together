import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../authentication/login_view.dart';
import '../../authentication/supabase/supabase_provider.dart';
import '../../core/error_handling/snackbar_controller.dart';
import '../../core/molecules/list_items/custom_list_tile.dart';
import '../../invite/household_invite_view.dart';
import '../controllers/household_controller.dart';
import '../models/household/household.dart';
import '../widgets/custom_app_bar_delegate.dart';
import 'household_create_view.dart';

class HouseholdView extends ConsumerStatefulWidget {
  const HouseholdView({Key? key}) : super(key: key);
  static String get route => 'household';

  @override
  ConsumerState<HouseholdView> createState() => _HouseholdViewState();
}

class _HouseholdViewState extends ConsumerState<HouseholdView> {
  final _log = Logger('Household View');
  @override
  Widget build(BuildContext context) {
    snackbarDisplayer(context, ref);
    ref.listen<HouseholdState>(householdControllerProvider, (previous, next) {
      if (next.household.value == null) {
        context.goNamed(HouseholdCreateView.route);
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
                context.goNamed(HouseholdInviteView.route);
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              onTap: _signOut,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    final response = await ref.read(supabaseProvider).auth.signOut();

    final error = response.error;
    if (error != null) {
      _log.warning(error.message);
      if (mounted) context.goNamed(LoginView.route);
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
      onRefresh: () async => ref.read(householdControllerProvider.notifier).fetchExpenses(),
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final expense = household!.expenses[index];
                return CustomListTile(expense: expense);
              },
              childCount: household?.expenses.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Household?>('household', household));
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
          '${household?.totalSpent} kr',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Household?>('household', household));
  }
}
