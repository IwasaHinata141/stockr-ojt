import 'package:flutter/material.dart';

void returnPostScreenDialog(
  BuildContext context,
  notifier
) {
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
                              "変更を破棄しますか？",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                              "このまま破棄すると編集した内容が",
                              style: TextStyle(fontSize: 12),
                            ),
              const Text("全て失われます", style: TextStyle(fontSize: 12)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: const Text("破棄する",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))),
                                  const SizedBox(width: 10,),
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
                            notifier.updateCheck(false);
                          },
                          child: const Text("編集を続ける",
                              style: TextStyle(
                                  color: Color(0xFF768D8F),
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