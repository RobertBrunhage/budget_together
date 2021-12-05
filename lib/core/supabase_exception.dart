import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../localization/generated/l10n.dart';

class SupabaseException extends HttpException {
  SupabaseException(PostgrestError error) : super(_supabaseError(error));

  static String _supabaseError(PostgrestError error) {
    switch (error.code) {
      case 'SocketException':
        return S.current.noInternetConnection;
      default:
        return error.message;
    }
  }
}
