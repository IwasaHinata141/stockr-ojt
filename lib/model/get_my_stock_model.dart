import 'package:cloud_firestore/cloud_firestore.dart';
import 'stock_model.dart';

final db = FirebaseFirestore.instance;

Stream<List<Stock>> getMyStock() {
 return db.collection('user').doc("uid1").collection("stocks").snapshots().map((querySnapshot) {
    List<Stock> stockList = [];
    for (var docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> stockData = docSnapshot.data();
      stockData['stockCode'] = docSnapshot.id;
      stockList.add(Stock.fromJson(stockData));
    }
    // 並び替えを行う
    stockList.sort((a, b) => (b.updatedAt ?? b.createdAt).compareTo(a.updatedAt ?? a.createdAt));
    return stockList;
  });
}