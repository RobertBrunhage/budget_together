// ignore_for_file: do_not_use_environment

class Config {
  final anonKey = const String.fromEnvironment('supabase_publicKey');
  final url = const String.fromEnvironment('supabase_url');
  final sentryDns = const String.fromEnvironment('sentry_dns');
}
