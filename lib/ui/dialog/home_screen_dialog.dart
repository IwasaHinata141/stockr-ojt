import 'package:flutter/material.dart';
import '../post_screen/view_model/post_screen_view_model.dart';

void returnHomeScreenDialog(
    BuildContext context, int index, PostScreenViewModel postNotifier) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(8),
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 200,
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFEAEEEF)),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                              "選択したストックを削除しますか？",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                              "削除したストックは復元できません",
                              style: TextStyle(fontSize: 12),
                            ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: const BoxDecoration(),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFFFFF),
                            side: const BorderSide(color: Color(0xFF768D8F)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("キャンセル",
                              style: TextStyle(
                                  color: Color(0xFF768D8F),
                                  fontWeight: FontWeight.bold)))),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF87951),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            postNotifier.delete(index);
                            Navigator.pop(context);
                          },
                          child: const Text("削除",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
