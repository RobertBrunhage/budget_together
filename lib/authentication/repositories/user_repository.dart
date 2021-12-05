import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user_entity.dart';
import '../login_view.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

class UserRepository {
  Future<void> createOrUpdateUser(UserEntity user) async {
    final response = await supabase.from('profiles').upsert(user.toJson()).execute();
    if (response.error != null) {
      throw HttpException(response.error?.message ?? 'no');
    }
  }
}
