import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> createOrUpdateUser(User user) async {
    await userRepository.createOrUpdateUser(user.toEntity());
  }
}
