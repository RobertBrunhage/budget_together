import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/supabase/supabase_provider.dart';
import '../../invite/controllers/invite_controller.dart';
import '../controllers/household_controller.dart';
import 'household_view.dart';

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
                    final currentUserId = ref.read(supabaseProvider).auth.currentUser!.id;
                    await ref.read(householdControllerProvider.notifier).createHousehold(
                          currentUserId,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('username', username));
  }
}
