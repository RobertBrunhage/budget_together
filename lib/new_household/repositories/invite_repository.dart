import 'dart:io';

import 'package:budget_together/new_authentication/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inviteRepositoryProvider = Provider<InviteRepository>((ref) {
  return InviteRepository();
});

class InviteRepository {
  Future<void> invite(String email, int householdId) async {
    try {
      await supabase
          .from('invites')
          .upsert({'household_id': householdId, 'email': email}).execute();
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> acceptAllInvites(String email) async {
    try {
      final response =
          await supabase.from('invites').select().eq('email', email).execute();

      final invites = List.from(response.data);

      for (var invite in invites) {
        await supabase.from('household_profiles').upsert({
          'household_id': invite['household_id'],
          'profile_id': supabase.auth.currentUser!.id
        }).execute();

        await supabase
            .from('invites')
            .delete()
            .eq('email', supabase.auth.currentUser!.email)
            .eq('household_id', invite['household_id'])
            .execute();
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
