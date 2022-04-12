import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/chat/chat.dart';
import 'package:flutter_wechat_demo/contact/contact.dart';
import 'package:flutter_wechat_demo/discover/discover.dart';
import 'package:flutter_wechat_demo/mine/mine.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //初始化pagecontroller，用来控制page页面
  final _controller = PageController(
    initialPage: 0
  );
  //声明到这里，可以默认保存，避免内次切换都要重新初始化,如果想重新初始化，可以特殊处理
  int _pageIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //这是一个 Widget 类型，可以自定义 tabbar，这里使用系统的来测试
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
          _controller.jumpToPage(index);
        },
        //设置了默认会显示字体，否则只有选中的才显示字体
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        //设置为混合类型，默认未选中只显示一个icon图片
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        //设置里面组件
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: "聊天",
              icon: Image.asset('images/tabbar_chat.png',
                  width: 20,
                  height: 20
              ),
              activeIcon: Image.asset('images/tabbar_chat_hl.png',
                  width: 20,
                  height: 20
              )
          ),
          BottomNavigationBarItem(
              label: "联系人",
              icon: Image.asset('images/tabbar_contact.png',
                  width: 20,
                  height: 20
              ),
              activeIcon: Image.asset('images/tabbar_contact_hl.png',
                  width: 20,
                  height: 20
              )
          ),
          BottomNavigationBarItem(
              label: "发现",
              icon: Image.asset('images/tabbar_discover.png',
                  width: 20,
                  height: 20
              ),
              activeIcon: Image.asset('images/tabbar_discover_hl.png',
                  width: 20,
                  height: 20
              )
          ),
          BottomNavigationBarItem(
            label: "我的",
              icon: Image.asset('images/tabbar_mine.png',
                  width: 20,
                  height: 20
              ),
              activeIcon: Image.asset('images/tabbar_mine_hl.png',
                  width: 20,
                  height: 20
              )
          )
        ],
      ),
      body: PageView(
        controller: _controller,
        //不设置默认可以左右活动，如果不想左右滑动如下设置，可以根据ios或者android来设置
        // physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
        children: const [
          ChatList(),
          Contact(),
          Discover(),
          Mine()
        ],
      ),
    );
  }
}
