import '../../../model/hancle_stocks/add_my_stock_model.dart';
import '../../../model/hancle_stocks/update_my_stock_model.dart';
import '../../../model/hancle_stocks/delete_my_stock_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/get_datas/get_my_stock_model.dart';
import '../../../model/freezed/stock_model.dart';


class PostScreenViewModel extends StateNotifier<AsyncValue<List<Stock>>> {
  PostScreenViewModel() : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    getMyStock().listen((stocks) {
      state = AsyncValue.data(stocks);
    });
  }

  Future<void> post(String content) async {
    DateTime timeStamp = DateTime.now();
    final String stockCode = const Uuid().v4();
    bool response = await addMyStock(content, timeStamp, stockCode);
    print(response);
  }

  Future<void> delete(int index) async {
    bool response = await deleteMyStock(state.value![index].stockCode);
    print(response);
  }

  Future<void> updateStock(int index, String content) async {
    DateTime timeStamp = DateTime.now();
    bool response = await updateMyStock(content, timeStamp, state.value![index].stockCode);
    print(response);
  }
}

final postScreenViewModelProvider = StateNotifierProvider<PostScreenViewModel, AsyncValue<List<Stock>>>((ref) {
  return PostScreenViewModel();
});

class TextStateNotifier extends StateNotifier<String> {
  TextStateNotifier() : super('');

  void updateText(String text) {
    state = text;
  }
}

final textStateNotifierProvider = StateNotifierProvider<TextStateNotifier, String>((ref) {
  return TextStateNotifier();
});


class CheckOfModalState extends StateNotifier<bool> {
  CheckOfModalState() : super(false);

  void updateCheck(bool check) {
    state = check;
  }
}

final checkOfModalStateProvider = StateNotifierProvider<CheckOfModalState, bool>((ref) {
  return CheckOfModalState();
});