import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockr_ojt/ui/home_screen/view/home_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:stockr_ojt/ui/dashboard_screen/view/dashboard_screen_view.dart';

void main() async {

 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const scope = ProviderScope(child:  MyApp());
  runApp(scope);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stockr_OJT',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  // bottomNavigationBarのページのリスト
  late final _pageWidgets = [
    // ホーム画面
    const HomeScreen(),
    // ダッシュボード画面
    const DashBoardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pageWidgets[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.1,
        child: BottomNavigationBar(
          // 選択中のアイテムindex
          currentIndex: _currentIndex,
          // タップ時のハンドラ
          onTap: (selectedIndex) => setState(() {
            _currentIndex = selectedIndex;
          }),
          // ページ下部に表示するアイテム
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.05, // 画面の幅の10%をアイコンの幅に設定
                height: screenWidth * 0.05, // 画面の幅の10%をアイコンの高さに設定
                child: const ImageIcon(AssetImage('images/Vector.png')),
              ),
              label: "ストック",
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: screenWidth * 0.05, // 画面の幅の10%をアイコンの幅に設定
                height: screenWidth * 0.05, // 画面の幅の10%をアイコンの高さに設定
                child: const ImageIcon(AssetImage('images/icon.png')),
              ),
              label: "レポート",
            ),
          ],
          selectedItemColor: const Color(0xFF52C2CD), // 選択されたアイテムの色
          unselectedItemColor: const Color(0xFF374142), // 選択されていないアイテムの色
        ),
      ),
    );
  }
}