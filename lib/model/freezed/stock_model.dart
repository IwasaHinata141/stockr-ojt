import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_model.freezed.dart';

@freezed
class Stock with _$Stock {
  const factory Stock({
    required String text,
    required DateTime createdAt,
    required String stockCode,
    DateTime? updatedAt,
  }) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      text: json['text'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      stockCode: json['stockCode'] as String,
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() : null,
    );
  }
}