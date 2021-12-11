import 'package:supabase_flutter/supabase_flutter.dart';

GoTrueClient stubGoTrueClient() {
  final goTrueClient = GoTrueClient();

  final user = User(
    id: '',
    appMetadata: <String, dynamic>{},
    userMetadata: <String, dynamic>{},
    aud: '',
    email: 'test@gmail.com',
    phone: '',
    createdAt: '',
    role: '',
    updatedAt: '',
  );

  goTrueClient.currentUser = user;
  return goTrueClient;
}
