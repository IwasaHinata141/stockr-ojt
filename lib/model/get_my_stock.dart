import 'package:freezed_annotation/freezed_annotation.dart';
import './get_my_stock_model.dart';

part 'get_my_stock.freezed.dart';


@freezed
class Stock with _$Stock {
  const factory Stock({
    @Default([]) List<Map<String, dynamic>> stockList,

  }) = _Stock;
}