import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/chat/chat_list_data.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
    with AutomaticKeepAliveClientMixin {
  List<ChatListData> list = [];
  List popList = [
    {'imgUrl': 'images/发起群聊.png', 'name': '发起群聊'},
    {'imgUrl': 'images/添加朋友.png', 'name': '添加朋友'},
    {'imgUrl': 'images/扫一扫1.png', 'name': '扫一扫'},
    {'imgUrl': 'images/收付款.png', 'name': '收付款'},
  ];

  //重写该方法，保持住状态,且只有StatefulWidget才可以
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('ChatListinitState');
    super.initState();
    getData().then((res) {
      print(res);
      setState(() {});
    });
  }

  Future<List<dynamic>> getData() async {
    Response res = await get(
        Uri.parse("http://rap2api.taobao.org/app/mock/224518/api/chat/list"));
    final body = jsonDecode(res.body);
    final chatList = body["chat_list"];
    for (final item in chatList) {
      final chatData = ChatListData.formJson(item);
      list.add(chatData);
    }
    return list;
  }

  Widget itemForRow(BuildContext context, int index) {
    //这个就是跟微信首页聊天的一样，可以设置图片，标题内容
    final item = list[index];
    return Column(
      children: [
        ListTile(
          title: Text(item.name,
              style: const TextStyle(fontSize: 12, color: Colors.black87)),
          subtitle: Text(
            item.message,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            overflow: TextOverflow.ellipsis, //设置省略效果
          ),
          leading: CircleAvatar(backgroundImage: NetworkImage(item.imgUrl)),
        ),
        Row(
          children: [
            //两个Container都可以
            Container(width: 46, height: 1, color: Colors.white),
            Expanded(child: Container(height: 1, color: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1))),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("聊天"),
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
        elevation: 0,
        //去掉阴影
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              offset: const Offset(0, 56),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: Image.asset("images/圆加.png", width: 20),
              ),
              itemBuilder: (BuildContext context) {
                return popList.map<PopupMenuItem>((item) {
                  return PopupMenuItem(
                    child: Row(
                      children: [
                        Image.asset(item['imgUrl'], width: 18),
                        const SizedBox(width: 10),
                        Text(item['name'],
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: itemForRow,
        itemCount: list.length,
      ),
    );
  }
}
