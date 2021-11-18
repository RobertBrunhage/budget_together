import 'package:budget_together/Authentication/models/user.dart';
import 'package:budget_together/Authentication/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(userRepository: ref.watch(userRepositoryProvider));
});

class AuthService {
  final UserRepository userRepository;
  AuthService({
    required this.userRepository,
  });

  Future<void> createOrUpdateUser(User user) async {
    await userRepository.createOrUpdateUser(user.toEntity());
  }
}
