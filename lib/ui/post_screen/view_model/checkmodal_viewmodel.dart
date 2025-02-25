import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckOfPriviousListNotifier extends StateNotifier<bool> {
  CheckOfPriviousListNotifier() : super(false);

  void updateCheck(bool check) {
    state = check;
  }
}

final checkOfPriviousListProvider = StateNotifierProvider<CheckOfPriviousListNotifier, bool>((ref) {
  return CheckOfPriviousListNotifier();
});