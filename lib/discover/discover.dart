
import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/item_cell.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> with AutomaticKeepAliveClientMixin {
  //重写该方法，保持住状态,且只有StatefulWidget才可以
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("发现"),
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
        elevation: 0 //去掉阴影
      ),
      body: Container(
        color: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
        child: ListView(
            children: const <Widget>[
              ItemCell(imageUrl: "images/朋友圈.png", text: "朋友圈", subImageUrl: 'images/head.jpg', subText: "2个朋友赞过"),
              //也可以使用Container
              SizedBox(height: 6),
              ItemCell(imageUrl: "images/扫一扫2.png", text: "扫一扫", hasLine: true),
              ItemCell(imageUrl: "images/摇一摇.png", text: "摇一摇"),

              SizedBox(height: 6),
              ItemCell(imageUrl: "images/看一看.png", text: "看一看", hasLine: true),
              ItemCell(imageUrl: "images/搜一搜.png", text: "搜一搜"),

              SizedBox(height: 6),
              ItemCell(imageUrl: "images/附近.png", text: "附近"),

              SizedBox(height: 6),
              ItemCell(imageUrl: "images/购物.png", text: "购物", hasLine: true),
              ItemCell(imageUrl: "images/游戏.png", text: "游戏"),

              SizedBox(height: 6),
              ItemCell(imageUrl: "images/小程序.png", text: "小程序"),
          ]
        ),
      )
    );
  }
}
