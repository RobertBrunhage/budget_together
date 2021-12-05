import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../authentication/supabase/supabase_provider.dart';
import '../entities/household/household_entity.dart';

final householdRepositoryProvider = Provider<HouseholdRepository>((final ref) {
  return HouseholdRepository(
    ref.watch(supabaseProvider),
  );
});

class HouseholdRepository {
  HouseholdRepository(this._supabaseClient);

  final supa.SupabaseClient _supabaseClient;

  Future<int> createHousehold(final String userId, final String householdName) async {
    final response =
        await _supabaseClient.from('households').upsert({'creator': userId, 'name': householdName}).execute();

    if (response.error != null) {
      throw HttpException(response.error!.message);
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    final household = HouseholdEntity.fromJson(data[0]);

    await _supabaseClient.from('household_profiles').upsert({
      'profile_id': userId,
      'household_id': household.id,
    }).execute();

    return household.id;
  }

  Future<HouseholdEntity?> fetchHousehold(final String userId) async {
    final response = await _supabaseClient
        .from('household_profiles')
        .select(
          'households (id, name, creator, expenses (id, amount, transaction_date, categories (id, name), profiles (id, name)))',
        )
        .eq('profile_id', userId)
        .execute();

    if (response.error != null) {
      throw HttpException(response.error!.message);
    }

    if ((response.data as List).isEmpty) {
      return null;
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    final household = data[0]['households']! as Map<String, dynamic>;

    final firstHouseholdFound = HouseholdEntity.fromJson(household);
    return firstHouseholdFound;
  }
}
