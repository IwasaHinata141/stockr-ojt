import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

Future<bool> deleteMyStock(String stockCode) async {
  final myStockRef = db.collection('users').doc("uid1").collection("stocks").doc(stockCode);

  try {
    await myStockRef.delete();
    return true;
  } catch (e) {
    print("削除に失敗しました: $e");
    return false;
  }
}