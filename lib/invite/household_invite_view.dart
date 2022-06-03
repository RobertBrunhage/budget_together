import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/error_handling/snackbar_controller.dart';
import '../household/views/household_view.dart';
import '../localization/generated/l10n.dart';
import 'controllers/invite_controller.dart';

class HouseholdInviteView extends ConsumerStatefulWidget {
  const HouseholdInviteView({Key? key}) : super(key: key);
  static String get route => 'householdInviteView';

  @override
  ConsumerState<HouseholdInviteView> createState() => _HouseholdCreateViewState();
}

class _HouseholdCreateViewState extends ConsumerState<HouseholdInviteView> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  @override
  Widget build(BuildContext context) {
    snackbarDisplayer(context, ref);
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
                    return S.of(context).emailIsRequiredMessage;
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
                    final result = await ref.read(inviteControllerProvider.notifier).invite(email);
                    if (result.isSuccess()) {
                      if (mounted) {
                        context.goNamed(HouseholdView.route);
                      }
                    }
                  }
                },
                child: Text(S.of(context).submit),
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
