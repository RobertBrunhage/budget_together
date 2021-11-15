import 'dart:io';

import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Authentication/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

class UserRepository {
  Future<void> createOrUpdateUser(User user) async {
    final response =
        await supabase.from('profiles').upsert(user.toMap()).execute();
    if (response.error != null) {
      throw HttpException(response.error?.message ?? 'no');
    }
  }
}
