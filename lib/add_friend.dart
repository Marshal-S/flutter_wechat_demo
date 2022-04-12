
import 'package:flutter/material.dart';

class AddFriend extends StatelessWidget {
  final String title;

  const AddFriend({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
          elevation: 0 //去掉阴影
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("我是添加朋友界面"),
      ),
    );
  }
}
