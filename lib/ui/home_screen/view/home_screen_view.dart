import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockr_ojt/model/stock_model.dart';
import '../../post_screen/view/post_screen_view.dart';
import '../../post_screen/view_model/post_screen_view_model.dart';
import '../../../ui/dialog/home_screen_dialog.dart';
import '../../../../model/get_my_stock_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(postScreenViewModelProvider);
    final postNotifier = ref.read(postScreenViewModelProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: asyncData.when(
            data: (data) {
              final count = data.length;
              final postNotifier = ref.read(postScreenViewModelProvider.notifier);
              return Column(
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
                                ? StockListWidget(
                                    data: data,
                                    notifier: postNotifier,
                                    count: count)
                                : FirstTimeWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, stack) => Text('エラーが発生しました: $error'),
          ),
        ),
      ),
      floatingActionButton: asyncData.when(
        data:(data){
          final count = data.length;
          return FloatingActionButton(
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => PostScreen(
                  index: count,
                  content: "",
                  checkOfPriviousList: false,
                ),
              );
            },
            tooltip: 'add stock',
            backgroundColor: Color(0xFF52C2CD),
            shape: CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          );
        },
        loading: () => Container(),
        error: (error, stack) => Container(),
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Container(
                child: Text('日々の仕事・生活で考えたことや、', style: TextStyle(fontSize: 12)),
              ),
              Container(
                child: Text(
                  '忘れずにおきたいと思った気づきを貯めていきましょう。',
                  style: TextStyle(fontSize: 12),
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

  final List<Stock> data;
  final PostScreenViewModel notifier;
  final int count;

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
      width: double.infinity,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: count,
            itemBuilder: (context, index) {
              final timeStamp = data[index].updatedAt ?? data[index].createdAt;
              final timeStampText = isToday(timeStamp)
                  ? DateFormat('HH:mm').format(timeStamp)
                  : DateFormat('yyyy/MM/dd HH:mm').format(timeStamp);

              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => PostScreen(
                      index: index,
                      content: data[index].text,
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
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          'images/normal.png',
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                data[index].text,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  timeStampText,
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFFA2A2A2)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    returnHomeScreenDialog(
                                        context, index, notifier);
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