import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/login_view.dart';

final inviteRepositoryProvider = Provider<InviteRepository>((final ref) {
  return InviteRepository();
});

class InviteRepository {
  Future<void> invite(final String email, final int householdId) async {
    final response = await supabase.from('invites').upsert({'household_id': householdId, 'email': email}).execute();
    if (response.error != null) {
      throw HttpException(response.error!.message);
    }
  }

  Future<void> acceptAllInvites(final String email) async {
    final response = await supabase.from('invites').select().eq('email', email).execute();
    if (response.error != null) {
      throw HttpException(response.error!.message);
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    for (final invite in data) {
      await supabase.from('household_profiles').upsert(<String, Object>{
        'household_id': invite['household_id'] as int,
        'profile_id': supabase.auth.currentUser!.id,
      }).execute();

      await supabase
          .from('invites')
          .delete()
          .eq('email', supabase.auth.currentUser!.email)
          .eq('household_id', invite['household_id'])
          .execute();
    }
  }
}
