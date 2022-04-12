import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //去掉debug自选
      debugShowCheckedModeBanner: false,
      //Android任务管理器界面title，可以设置称自己的app名字
      title: "Flutter Demo",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        cardColor: const Color.fromRGBO(0x33, 0x33, 0x33, 0.8),
      ),
      home: const HomePage()
    );
  }
}

