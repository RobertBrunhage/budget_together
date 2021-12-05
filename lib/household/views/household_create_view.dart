import 'package:budget_together/authentication/login_view.dart';
import 'package:budget_together/household/controllers/household_controller.dart';
import 'package:budget_together/household/views/household_view.dart';
import 'package:budget_together/invite/controllers/invite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HouseholdCreateView extends ConsumerStatefulWidget {
  const HouseholdCreateView({Key? key}) : super(key: key);
  static String get route => 'householdCreateView';

  @override
  ConsumerState<HouseholdCreateView> createState() => _HouseholdCreateViewState();
}

class _HouseholdCreateViewState extends ConsumerState<HouseholdCreateView> {
  final _formKey = GlobalKey<FormState>();
  String username = '';

  @override
  void initState() {
    super.initState();
    ref.read(inviteControllerProvider.notifier).acceptAllInvites();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HouseholdState>(householdControllerProvider, (previous, next) {
      if (next.household.value != null) {
        context.goNamed(HouseholdView.route);
      }
    });
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    await ref.read(householdControllerProvider.notifier).createHousehold(
                          supabase.auth.currentUser!.id,
                          username,
                        );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
