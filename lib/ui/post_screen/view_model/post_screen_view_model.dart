import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'post_screen_view_model.g.dart';

@riverpod
class PostScreenViewModel extends _$PostScreenViewModel {
  @override
  List<Map> build() {
    return const [];
  }

  void post(String content) {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('HH:mm');
    String timeStamp = outputFormat.format(now);
    final newState = List<Map>.from(state)
      ..add({'content': content, 'timeStamp': timeStamp});
    state = newState;
  }

  void delete(int index) {
    final newState = List<Map>.from(state)..removeAt(index);
    state = newState;
  }

  void update(int index, String content) {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('HH:mm');
    String timeStamp = outputFormat.format(now);
    final newState = List<Map>.from(state)
      ..removeAt(index)
      ..insert(index, {'content': content, 'timeStamp': timeStamp});
    state = newState;
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




