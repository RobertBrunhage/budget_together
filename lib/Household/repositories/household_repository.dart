import 'dart:io';

import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/entities/household/household_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final householdRepositoryProvider = Provider<HouseholdRepository>((ref) {
  return HouseholdRepository();
});

class HouseholdRepository {
  Future<int> createHousehold(String userId, String householdName) async {
    try {
      final response = await supabase
          .from('households')
          .upsert({'creator': userId, 'name': householdName}).execute();

      final households = List.from(response.data);

      final household = HouseholdEntity.fromJson(households[0]);

      await supabase.from('household_profiles').upsert({
        'profile_id': userId,
        'household_id': household.id,
      }).execute();

      return household.id;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<HouseholdEntity?> fetchHousehold(String userId) async {
    final response = await supabase
        .from('household_profiles')
        .select(
            'households (id, name, creator, expenses (id, amount, categories (id, name), profiles (id, name)))')
        .eq('profile_id', userId)
        .execute();

    if ((response.data as List).isEmpty) {
      return null;
    }

    final household = response.data[0]['households'];

    final firstHouseholdFound = HouseholdEntity.fromJson(household);
    return firstHouseholdFound;
  }
}
