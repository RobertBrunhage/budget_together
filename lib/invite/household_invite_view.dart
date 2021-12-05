import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../household/views/household_view.dart';
import 'controllers/invite_controller.dart';

class HouseholdInviteView extends ConsumerStatefulWidget {
  const HouseholdInviteView({final Key? key}) : super(key: key);
  static String get route => 'householdInviteView';

  @override
  ConsumerState<HouseholdInviteView> createState() => _HouseholdCreateViewState();
}

class _HouseholdCreateViewState extends ConsumerState<HouseholdInviteView> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (final value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (final value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    await ref.read(inviteControllerProvider.notifier).invite(email);

                    if (!mounted) return;
                    context.goNamed(HouseholdView.route);
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
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
  }
}
