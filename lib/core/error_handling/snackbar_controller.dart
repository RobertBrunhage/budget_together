import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SnackbarState {
  SnackbarState({
    required this.message,
  });
  final String message;

  SnackbarState copyWith({
    String? message,
  }) {
    return SnackbarState(
      message: message ?? this.message,
    );
  }
}

final snackbarControllerProvider = StateNotifierProvider<SnackbarController, SnackbarState>((ref) {
  return SnackbarController();
});

class SnackbarController extends StateNotifier<SnackbarState> {
  SnackbarController() : super(SnackbarState(message: ''));

  void setSnackbarMessage(String message) {
    state = state.copyWith(message: message);
  }
}

void snackbarDisplayer(BuildContext context, WidgetRef ref) {
  ref.listen<SnackbarState>(snackbarControllerProvider, (previous, next) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(next.message),
      ),
    );
  });
}
