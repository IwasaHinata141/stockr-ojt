import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../model/add_my_stock_model.dart';
import '../../../model/update_my_stock_model.dart';
import '../../../model/delete_my_stock_model.dart';
import 'package:uuid/uuid.dart';

import '../../../model/get_my_stock_model.dart';
import '../../../model/stock_model.dart';

part 'post_screen_view_model.g.dart';

@riverpod
class PostScreenViewModel extends _$PostScreenViewModel {
  @override
  Stream<List<Stock>> build(){
    return getMyStock();
  }

  void post(String content) async {
    DateTime timeStamp = DateTime.now();
    final String stockCode = Uuid().v4();
    bool response = await addMyStock(content, timeStamp, stockCode);
    print(response);
  }

  void delete(int index) async {
    bool response = await deleteMyStock(state.value![index].stockCode);
    print(response);
  }

  void updateStock(
    int index,
    String content,
  ) async {
    DateTime timeStamp = DateTime.now();
    bool response =
        await updateMyStock(content, timeStamp, state.value![index].stockCode);
    print(response);
  }
}

@riverpod
class TextStateNotifier extends _$TextStateNotifier {
  @override
  String build() {
    return '';
  }

  void updateText(String text) {
    state = text;
  }
}

@riverpod
class CheckOfModalState extends _$CheckOfModalState {
  @override
  bool build() {
    return false;
  }

  void updateCheck(bool check) {
    state = check;
  }
}