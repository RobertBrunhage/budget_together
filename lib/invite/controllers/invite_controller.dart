import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/controllers/household_controller.dart';
import '../services/invite_service.dart';

class InviteState {}

final inviteControllerProvider = StateNotifierProvider<InviteController, InviteState>((final ref) {
  return InviteController(
    ref.watch(inviteServiceProvider),
    ref.watch(householdControllerProvider.notifier),
  );
});

class InviteController extends StateNotifier<InviteState> {
  InviteController(this._inviteService, this._householdController) : super(InviteState());

  final InviteService _inviteService;
  final HouseholdController _householdController;

  Future<void> invite(final String email) async {
    final householdId = _householdController.state.household.value!.id;
    await _inviteService.inviteUserToHousehold(email, householdId);
  }

  Future<void> acceptAllInvites() async {
    await _inviteService.acceptAllInvites();
    await _householdController.fetchHousehold();
  }
}
