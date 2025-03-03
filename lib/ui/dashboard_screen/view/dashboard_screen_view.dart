import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../dashboard_screen/viewmodel/dashboard_screen_viewmodel.dart';



class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dashBoardScreenViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: const Color(0xFFF8FAFA),
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'images/header_background.png',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
            child: Center(
              child: asyncData.when(
                data: (data) {
                  final score = data.score;
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(top: 60, left: 20),
                                    child: const Text(
                                      'レポート',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                  )),
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color(0xFFCAD5D6),
                                      width: 1,
                                    ),
                                  ),
                                  width: screenWidth * 0.95,
                                  height: screenHeight * 0.35,
                                  child: CircularPercentIndicator(
                                    animation: true,
                                    backgroundColor: const Color(0xFFEAEEEF),
                                    radius: screenWidth * 0.30,
                                    lineWidth: 12.0,
                                    percent: score/300,
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'ストックスコア',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xFF374142)),
                                        ),
                                        Text(
                                          '$score',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '$score/300',
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xFF374142))
                                        ),
                                      ],
                                    ),
                                    progressColor: const Color(0xFF52C2CD),
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                )
                                
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('エラーが発生しました: $error'),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}