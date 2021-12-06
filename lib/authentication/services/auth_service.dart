import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../core/error_handling/failure.dart';
import '../../core/error_handling/supabase_exception.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(userRepository: ref.watch(userRepositoryProvider));
});

class AuthService {
  const AuthService({
    required this.userRepository,
  });

  final UserRepository userRepository;

  Future<Result<Failure, void>> createOrUpdateUser(User user) async {
    try {
      await userRepository.createOrUpdateUser(user.toEntity());
      return const Success(null);
    } on SupabaseException catch (e) {
      return Error(Failure(e.message));
    }
  }
}
