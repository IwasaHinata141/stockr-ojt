import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Future<bool> updateMyStock(String text,DateTime timeStamp,String stockCode) async {
  final myStockRef = db.collection('users').doc("uid1").collection("stocks").doc(stockCode);

  final Map<String, dynamic> stockData = {
    'text': text,
    'updatedAt': timeStamp,
  };

  try {
    await myStockRef.update(stockData);
    return true;
  } catch (e) {
    print("上書きに失敗しました: $e");
    return false;
  }
}