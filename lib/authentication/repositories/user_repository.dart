import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../core/error_handling/supabase_exception.dart';
import '../entities/user_entity.dart';
import '../supabase/supabase_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    ref.watch(supabaseProvider),
  );
});

class UserRepository {
  UserRepository(this._supabaseClient);
  final supa.SupabaseClient _supabaseClient;

  Future<void> createOrUpdateUser(UserEntity user) async {
    final response = await _supabaseClient.from('profiles').upsert(user.toJson()).execute();
    if (response.error != null) {
      throw SupabaseException(response.error!);
    }
  }
}
