import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Future<bool> addMyStock(String text, DateTime timeStamp, String stockCode) async {
  final myStockRef = db.collection('user').doc("uid1").collection("stocks").doc(stockCode);

  final Map<String, dynamic> stockData = {
    'text': text,
    'createdAt': timeStamp,
  };

  try {
    await myStockRef.set(stockData);
    return true;
  } catch (e) {
    print("書き込みに失敗しました: $e");
    return false;
  }
}