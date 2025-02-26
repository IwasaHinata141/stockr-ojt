import 'package:flutter/material.dart';

void returnPostScreenDialog(
  BuildContext context,
  notifier
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(8),
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 200,
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFEAEEEF)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                  child: const Text(
                "変更を破棄しますか？",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: const Text(
                "このまま破棄すると編集した内容が",
                style: TextStyle(fontSize: 12),
              )),
              Container(
                  child: const Text("全て失われます", style: TextStyle(fontSize: 12))),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
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
                          child: Text("破棄する",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))),
                                  SizedBox(width: 10,),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4, 
                      height: 50,
                      decoration: BoxDecoration(),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFFFFF),
                            side: BorderSide(color: const Color(0xFF768D8F)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            notifier.updateCheck(false);
                          },
                          child: Text("編集を続ける",
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