import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/login_view.dart';
import '../entities/household/household_entity.dart';

final householdRepositoryProvider = Provider<HouseholdRepository>((final ref) {
  return HouseholdRepository();
});

class HouseholdRepository {
  Future<int> createHousehold(final String userId, final String householdName) async {
    final response = await supabase.from('households').upsert({'creator': userId, 'name': householdName}).execute();

    if (response.error != null) {
      throw HttpException(response.error!.message);
    }

    final data = List<Map<String, dynamic>>.from(response.data as List<Map<String, dynamic>>);

    final household = HouseholdEntity.fromJson(data[0]);

    await supabase.from('household_profiles').upsert({
      'profile_id': userId,
      'household_id': household.id,
    }).execute();

    return household.id;
  }

  Future<HouseholdEntity?> fetchHousehold(final String userId) async {
    final response = await supabase
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
