import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../core/error_handling/failure.dart';
import '../../core/error_handling/snackbar_controller.dart';
import '../../household/controllers/household_controller.dart';
import '../services/invite_service.dart';

class InviteState {}

final inviteControllerProvider = StateNotifierProvider<InviteController, InviteState>((final ref) {
  return InviteController(
    ref.watch(inviteServiceProvider),
    ref.watch(householdControllerProvider.notifier),
    ref.watch(snackbarControllerProvider.notifier),
  );
});

class InviteController extends StateNotifier<InviteState> {
  InviteController(
    this._inviteService,
    this._householdController,
    this._snackbarController,
  ) : super(InviteState());

  final InviteService _inviteService;
  final HouseholdController _householdController;
  final SnackbarController _snackbarController;

  Future<Result<Failure, void>> invite(final String email) async {
    final householdId = _householdController.state.household.value!.id;
    final result = await _inviteService.inviteUserToHousehold(email, householdId);
    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (_) {
        log('Succeessfully invited $email');
      },
    );
    return result;
  }

  Future<Result<Failure, void>> acceptAllInvites() async {
    final result = await _inviteService.acceptAllInvites();

    result.when(
      (error) => _snackbarController.setSnackbarMessage(error.message),
      (_) {
        _householdController.fetchHousehold();
        log('Succeessfully accepted all invites');
      },
    );
    return result;
  }
}
