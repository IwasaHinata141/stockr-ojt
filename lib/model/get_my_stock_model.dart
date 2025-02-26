import 'package:cloud_firestore/cloud_firestore.dart';


final db = FirebaseFirestore.instance;

Future<List> getMyStock() async {
  final myStock = await db.collection('users').doc("test1").collection("stocks").get();

  // ドキュメントをリストに変換
  List<Map<String, dynamic>> stockList = myStock.docs.map((doc) => doc.data()).toList();
  return stockList;
}

Future<Map> getMyStockTest() async {
  // final myStockRef = db.collection('users').doc("test1").collection("stocks").doc("GC2B7Bh4Jme6ze78mcsf");
  final myStockRef = db.collection('users').doc("test2");
  Map<String,dynamic> response = {};


  await myStockRef.get().then(
  (DocumentSnapshot doc) {
    response = doc.data() as Map<String, dynamic>;
    print("test :${response}");
  },
  onError: (e) => print("Error getting document: $e"),
);
  return response;

}