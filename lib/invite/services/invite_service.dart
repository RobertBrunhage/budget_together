import 'package:budget_together/authentication/login_view.dart';
import 'package:budget_together/invite/repositories/invite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inviteServiceProvider = Provider<InviteService>((ref) {
  return InviteService(
    ref.watch(inviteRepositoryProvider),
  );
});

class InviteService {
  final InviteRepository _inviteRepository;

  InviteService(
    this._inviteRepository,
  );

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
