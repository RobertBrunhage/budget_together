import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

final supabaseProvider = Provider<supa.SupabaseClient>((ref) {
  return supa.Supabase.instance.client;
});
