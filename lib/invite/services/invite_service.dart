import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../authentication/supabase/supabase_provider.dart';
import '../repositories/invite_repository.dart';

final inviteServiceProvider = Provider<InviteService>((ref) {
  return InviteService(
    ref.watch(inviteRepositoryProvider),
    ref.watch(supabaseProvider),
  );
});

class InviteService {
  const InviteService(
    this._inviteRepository,
    this._supabaseClient,
  );

  final InviteRepository _inviteRepository;
  final supa.SupabaseClient _supabaseClient;

  Future<void> inviteUserToHousehold(String email, int householdId) async {
    return _inviteRepository.invite(
      email,
      householdId,
    );
  }

  Future<void> acceptAllInvites() {
    return _inviteRepository.acceptAllInvites(
      _supabaseClient.auth.currentUser!.email!,
    );
  }
}
