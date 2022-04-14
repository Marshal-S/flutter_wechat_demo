//索引字母表
import 'package:flutter/material.dart';

class ContactIndexs extends StatefulWidget {
  final Function(String letter, int index) onUpdateCallback; //声明一个回调

  final List<String> letterList;

  const ContactIndexs(
      {Key? key, required this.letterList, required this.onUpdateCallback})
      : super(key: key);

  @override
  State<ContactIndexs> createState() => _ContactIndexsState();
}

class _ContactIndexsState extends State<ContactIndexs> {
  int lastIndex = -1; //用于保存上一次点击的letter索引，避免连续回调
  double bubbleAligmentY = 1;

  //移动更新
  onUpdate(double dy) {
    //计算点击了哪一个，可以返回给外面，每一个高度是14
    final length = widget.letterList.length;
    // final height = MediaQuery.of(context).size.height; 屏幕高度
    final height = context.size!.height; //组件高度
    //获取内容高度
    const letterHeight = 14;
    final allLetterHeight = length * letterHeight;
    //获取第一个索引的起始y坐标
    final startY = (height - allLetterHeight) / 2;

    //由于计算嗾使是以父节点的空间来响应手势，起始坐标在最上方，之前计算好了第一个的位置
    var index = (dy - startY) ~/ letterHeight; //~/取模,即向下取整
    // final index = (length / letterHeight).floor(); //或者这个也行
    //由于往上滑或者往下，会出现越界，处理一下越界问题
    index = index.clamp(0, length - 1); //可以通过 clamp 方法处理数字越界问题
    if (index != lastIndex) {
      widget.onUpdateCallback(widget.letterList[index], index);
    }
    lastIndex = index;

    //计算气泡，内部使用，还没计算
    //之前已经计算出了start，用position的方式将会更简单，这里我们挑战使用alignment，计算百分比
    //第一个字符中间y坐标
    final firstLetterCy = startY + letterHeight / 2;
    //起泡与第一个字符中心点对齐需要移动坐标
    final halfHeight = height / 2;
    //由于中心点是0，上下是-1，所以计算出索引，要用halfHeight才是相当于中心点的坐标
    //而物体总移动，还需要抛去自己一半的高度(顶部对齐-1，中心对齐0)，所以少移动了半个物体的高度
    final radioY =
        (halfHeight - firstLetterCy - index * letterHeight) / (halfHeight - 30);

    setState(() {
      bubbleAligmentY = -radioY;
    });
  }

  //我们在 build尽量只做UI相关操作
  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for (String item in widget.letterList) {
      final wordWidget = SizedBox(
          height: 14, child: Text(item, style: const TextStyle(fontSize: 10)));
      words.add(wordWidget);
    }
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //左边气泡
          Container(
            alignment: Alignment(-0.15, bubbleAligmentY),
            child: lastIndex > -1
              ? Stack(
                  alignment: const Alignment(-0.15, 0),
                  children: [
                    Image.asset(
                      'images/气泡.png',
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      widget.letterList[lastIndex],
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                )
              : null,
          ),
          //右边索引
          GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) {
              //拖拽更新，pan实际走的也是这个，不信看看参数😂
              //世界坐标details.globalPosition
              //本地坐标details.localPosition
              onUpdate(details.localPosition.dy);
            },
            onVerticalDragStart: (DragStartDetails details) {
              //拖拽点击时
              onUpdate(details.localPosition.dy);
            },
            onVerticalDragEnd: (DragEndDetails details) {
              //拖拽结束
              lastIndex = -1;
              setState(() {});
            },
            //处理点击的
            onTapDown: (TapDownDetails details) {
              onUpdate(details.localPosition.dy);
            },
            onTapCancel: () {
              lastIndex = -1;
              setState(() {});
            },
            onTapUp: (TapUpDetails details) {
              lastIndex = -1;
              setState(() {});
            },
            child: SizedBox(
              width: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: words,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
