import 'dart:io';
import '../../../model/get_my_stock_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';
import '../../../model/get_my_stock.dart';
import '../../../model/get_my_stock_model.dart';

part 'post_screen_view_model.g.dart';

@riverpod
class PostScreenViewModel extends _$PostScreenViewModel {
  @override
  Future<List<Map<String,dynamic>>> build() async {
    return [];
    //(await getMyStock()).cast<Map<String, dynamic>>();
  }

  void post(String content) {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('HH:mm');
    String timeStamp = outputFormat.format(now);
    final newState = List<Map>.from(state as Iterable)
      ..add({'content': content, 'timeStamp': timeStamp});
    state = newState as AsyncValue<List<Map<String, dynamic>>>;
  }

  void delete(int index) {
    final newState = List<Map>.from(state as Iterable)..removeAt(index);
    state = newState as AsyncValue<List<Map<String, dynamic>>>;
  }

  @override
  void updatePost(int index, String content) {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('HH:mm');
    String timeStamp = outputFormat.format(now);
    final newState = List<Map<String,dynamic>>.from(state as Iterable)
      ..removeAt(index)
      ..insert(index, {'content': content, 'timeStamp': timeStamp});
       state = AsyncValue.data(newState);
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




