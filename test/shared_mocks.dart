import 'package:budget_together/authentication/services/auth_service.dart';
import 'package:budget_together/household/services/household_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockAuthService extends Mock implements AuthService {}

class MockHouseholdService extends Mock implements HouseholdService {}
