import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../authentication/supabase/supabase_provider.dart';
import '../../core/error_handling/failure.dart';
import '../../core/error_handling/supabase_exception.dart';
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

  Future<Result<Failure, void>> inviteUserToHousehold(String email, int householdId) async {
    try {
      await _inviteRepository.invite(
        email,
        householdId,
      );
      return const Success(null);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }

  Future<Result<Failure, void>> acceptAllInvites() async {
    try {
      await _inviteRepository.acceptAllInvites(
        _supabaseClient.auth.currentUser!.email!,
      );
      return const Success(null);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }
}
