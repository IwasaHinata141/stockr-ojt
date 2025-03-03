import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_model.freezed.dart';

@freezed
class Score with _$Score {
  const factory Score({
    required int score,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      score: json['score'] as int,
    );
  }
}