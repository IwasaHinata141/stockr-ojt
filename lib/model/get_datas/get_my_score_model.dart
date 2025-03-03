import 'package:cloud_firestore/cloud_firestore.dart';
import '../freezed/score_model.dart';


final db = FirebaseFirestore.instance;
  Stream<Score> getMyScore() {
  final docRef = db.collection("users").doc("uid1");
    return docRef.snapshots().map((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (!data.containsKey('score')) {
        return const Score(score: 0);
      }else{
        return Score.fromJson(data);
      }
    });
}