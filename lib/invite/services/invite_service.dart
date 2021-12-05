import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/login_view.dart';
import '../repositories/invite_repository.dart';

final inviteServiceProvider = Provider<InviteService>((ref) {
  return InviteService(
    ref.watch(inviteRepositoryProvider),
  );
});

class InviteService {
  const InviteService(
    this._inviteRepository,
  );

  final InviteRepository _inviteRepository;

  Future<void> inviteUserToHousehold(String email, int householdId) async {
    return _inviteRepository.invite(
      email,
      householdId,
    );
  }

  Future<void> acceptAllInvites() {
    return _inviteRepository.acceptAllInvites(
      supabase.auth.currentUser!.email!,
    );
  }
}
