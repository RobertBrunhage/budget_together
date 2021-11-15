import 'package:budget_together/Authentication/login.dart';
import 'package:budget_together/Household/household.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final householdRepositoryProvider = Provider<HouseholdRepository>((ref) {
  return HouseholdRepository();
});

class HouseholdRepository {
  Future<void> createHousehold(String userId, String householdName) async {
    try {
      final response = await supabase
          .from('households')
          .upsert({'creator': userId, 'name': householdName}).execute();

      final households = List.from(response.data);
      print(households[0]);

      final household = Household.fromMap(households[0]);

      await supabase.from('household_profiles').upsert({
        'profile_id': userId,
        'household_id': household.id,
      }).execute();
    } catch (e) {
      print(e);
    }
  }

  Future<Household?> fetchHousehold(String userId) async {
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

    final firstHouseholdFound = Household.fromMap(household);
    return firstHouseholdFound;
  }
}
