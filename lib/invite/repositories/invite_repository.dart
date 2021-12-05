import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../authentication/supabase/supabase_provider.dart';
import '../../core/supabase_exception.dart';

final inviteRepositoryProvider = Provider<InviteRepository>((final ref) {
  return InviteRepository(
    ref.watch(supabaseProvider),
  );
});

class InviteRepository {
  InviteRepository(this._supabaseClient);

  final supa.SupabaseClient _supabaseClient;

  Future<void> invite(final String email, final int householdId) async {
    final response =
        await _supabaseClient.from('invites').upsert({'household_id': householdId, 'email': email}).execute();
    if (response.error != null) {
      throw SupabaseException(response.error!);
    }
  }

  Future<void> acceptAllInvites(final String email) async {
    final response = await _supabaseClient.from('invites').select().eq('email', email).execute();
    if (response.error != null) {
      throw SupabaseException(response.error!);
    }

    final invites = List<Map<String, dynamic>>.from(response.data as List<dynamic>);

    for (final invite in invites) {
      await _supabaseClient.from('household_profiles').upsert(<String, Object>{
        'household_id': invite['household_id'] as int,
        'profile_id': _supabaseClient.auth.currentUser!.id,
      }).execute();

      await _supabaseClient
          .from('invites')
          .delete()
          .eq('email', _supabaseClient.auth.currentUser!.email)
          .eq('household_id', invite['household_id'])
          .execute();
    }
  }
}
