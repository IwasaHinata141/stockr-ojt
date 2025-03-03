import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockr_ojt/model/freezed/score_model.dart';
import '../../../model/get_datas/get_my_score_model.dart';


class DashBoardScreenViewModel extends StateNotifier<AsyncValue<Score>> {
  DashBoardScreenViewModel() : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    getMyScore().listen((stocks) {
      state = AsyncValue.data(stocks);
    });
  }
}


final dashBoardScreenViewModelProvider = StateNotifierProvider<DashBoardScreenViewModel, AsyncValue<Score>>((ref) {
  return DashBoardScreenViewModel();
});