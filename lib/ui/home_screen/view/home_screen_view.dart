import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ui/post_screen/view/post_screen_view.dart';
import '../../../ui/post_screen/view_model/post_screen_view_model.dart';
import '../../../ui/dialog/home_screen_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(postScreenViewModelProvider);
    final count = data.length;
    final postNotifier = ref.read(postScreenViewModelProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Color(0xFFF8FAFA),
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        'images/header_background.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 60, left: 20),
                            child: Text(
                              'ストック',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )),
                        // ストックの有無によって表示を分岐
                        count != 0
                            ? StockListWidget(data: data, notifier: postNotifier,count: count)
                            : FirstTimeWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => PostScreen(index: count,content: "",checkOfPriviousList: false,),
            );
          },
          tooltip: 'add stock',
          backgroundColor: Color(0xFF52C2CD),
          shape: CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class FirstTimeWidget extends StatelessWidget {
  const FirstTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFEAEEEF)),
      ),
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      width: double.infinity,
      child: Column(
        children: [
          Image.asset('images/stocks_empty.png'),
          Container(
            child: Text(
              '気づきをストック',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                child: Text('日々の仕事・生活で考えたことや、', style: TextStyle(fontSize: 11)),
              ),
              Container(
                child: Text(
                  '忘れずにおきたいと思った気づきを貯めていきましょう。',
                  style: TextStyle(fontSize: 11),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StockListWidget extends StatelessWidget {
  const StockListWidget({
    super.key,
    required this.data,
    required this.notifier,
    required this.count,
  });

  final List<Map> data;
  final PostScreenViewModel notifier;
  final int count;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      width: double.infinity,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: count,
            itemBuilder: (context, index) {


              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => PostScreen(
                      index: index,
                      content: data[index]['content'],
                      checkOfPriviousList: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFEAEEEF)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,

                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          data[index]['content'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data[index]['timeStamp'],
                            style: TextStyle(fontSize: 12, color: Color(0xFFA2A2A2)),
                          ),
                          GestureDetector(
                            onTap: () {
                              returnHomeScreenDialog(context, index, notifier);
                            },
                            child: Icon(
                              Icons.more_horiz_outlined,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      
                      
                      
                    ],
                  ),
                ),
              );



            },
          ),
        ],
      ),
    );
  }
}