
import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/add_friend.dart';
import 'package:flutter_wechat_demo/contact/contact_cell.dart';
import 'package:flutter_wechat_demo/contact/contact_indexs.dart';
import 'contact_datas.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> with AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();
  List<Friends> headerItems = [];
  List<Friends> friends = []; //可以通过函数获取
  List<String> letters = [];
  Map<String, double> lettersLocationMap = {};

  //重写该方法，保持住状态,且只有StatefulWidget才可以
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //生成头部数据
    headerItems = [
      Friends(imageUrl: 'images/新的朋友.png', name: "新的朋友"),
      Friends(imageUrl: 'images/群聊.png', name: "群聊"),
      Friends(imageUrl: 'images/标签.png', name: "标签"),
      Friends(imageUrl: 'images/公众号.png', name: "公众号"),
    ];

    //由于数据有限，这里采用dart中的级联运  算符，链式调用方法重复添加数据
    friends..addAll(defalutFriendsDatas)
      ..addAll(defalutFriendsDatas)
      ..addAll(defalutFriendsDatas);

    //对获取的数据进行排列,大于零交换,即从小到大排列
    friends.sort((a, b) => a.letter.compareTo(b.letter));
    //加入收藏列表
    friends
      ..insertAll(0, collectionList)
      ..insertAll(0, collectionList)
      ..insertAll(0, collectionList);

    //更新letter的同时，更新偏移量
    double offsetY = 47 * 4; //顶部的四个
    var offsetIndex = 0;
    var isFirst = true;
    for (final item in friends) {
      if (!letters.contains(item.letter)) {
        letters.add(item.letter);
        if (isFirst) {
          offsetY += offsetIndex * 47; //更新offsetY
          isFirst = false;
        }else {
          offsetY += (offsetIndex * 47 + 28);
        }
        lettersLocationMap[item.letter] = offsetY;
        offsetIndex = 0;
      }
      offsetIndex++;
    }

    //由于这里没有异步，是串行执行，所以不需要重新setState
  }

  jumpToLetter(String letter) {
    _controller.animateTo(lettersLocationMap[letter]!, duration: const Duration(microseconds: 400), curve: Curves.easeIn);
  }

  //设置Row，这里通过巧妙的方式设置section效果
  Widget itemForRow(BuildContext context, int index) {
    if (index < 4) {
      final item = headerItems[index];
      return ContactCell(imageUrl: item.imageUrl, text: item.name);
    }else {
      final item = friends[index - 4];
      if (index == 4) {
        return ContactCell(imageUrl: item.imageUrl, text: item.name, isShowLetter: true, letter: item.letter);
      }else {
        final lastItem = friends[index -  5];
        return ContactCell(imageUrl: item.imageUrl, text: item.name, isShowLetter: item.letter != lastItem.letter, letter: item.letter);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("联系人"),
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
        elevation: 0, //去掉阴影
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const AddFriend(title: "添加朋友")));
            },
            child: Image.asset(
              "images/添加朋友.png",
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _controller,
            itemBuilder: itemForRow,
            itemCount: headerItems.length + friends.length,
          ),
          ContactIndexs(
            onUpdateCallback: (String letter, int index) {
              print(letter);
              jumpToLetter(letter);
            },
            letterList: letters,
          ),
        ],
      ),
    );
  }
}




