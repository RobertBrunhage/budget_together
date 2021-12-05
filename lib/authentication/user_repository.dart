import 'dart:io';

import 'package:budget_together/authentication/entities/user_entity.dart';
import 'package:budget_together/authentication/login_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
