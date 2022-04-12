

import 'package:flutter/material.dart';

class ItemCell extends StatefulWidget {
  final String imageUrl;
  final String text;
  final String? subImageUrl;
  final String? subText;
  final bool hasLine;

  const ItemCell({Key? key, required this.imageUrl, required this.text, this.subImageUrl, this.subText, this.hasLine = false}) : super(key: key);

  @override
  State<ItemCell> createState() => _ItemCellState();
}

class _ItemCellState extends State<ItemCell> {
  Color backColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          backColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          backColor = Colors.grey;
        });
      },
      onTapCancel: () {
        setState(() {
          backColor = Colors.white;
        });
      },
      child: Column(
        children: [
          Container(
            color: backColor,
            height: 46,
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        widget.imageUrl,
                        width: 16,
                        height: 16,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        width: 14,
                      ),
                      Text(
                          widget.text,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black
                          )
                      ),
                    ],
                  ),

                  Row(
                    children: [
                        Row(
                          children: [
                            //也可以使用三目运算符
                              //剪裁图片，如果设置border，请使用 container的
                              //右上角红圈的话，Stack嵌套Position即可
                            widget.subImageUrl != null ?
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  //头像，这里采用其中一种方式，剪裁，另外一种在下面
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(
                                      widget.subImageUrl!,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.fitWidth,
                                    )
                                  ),

                                  // 红点，可以一张图片处理
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      //设置了 decoration 不能设置Container的color属性
                                      decoration: BoxDecoration(
                                        //也可以设置image属性,给图片加圆角
                                        color: Colors.red,
                                        border: Border.all(color: Colors.red, width: 1),
                                        borderRadius: const BorderRadius.all(Radius.circular(3))
                                      ),
                                    )
                                  )
                                ],
                              )
                            ) : Container(),

                            const SizedBox(width: 2),

                            widget.subText != null ?
                              Text(
                                  widget.subText!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black
                                  )
                              ) : Container(),
                          ],
                      ),
                      const SizedBox(width: 2),
                      Image.asset(
                        "images/icon_right.png",
                        width: 12,
                        height: 12,
                        fit: BoxFit.fitWidth,
                      )
                    ],
                  )
                ]
            ),
          ),

          //通过三目运算符来动态控制UI，这里只是列举出使用方案
          widget.hasLine ?
          Row(
            children: [
              //两个Container都可以
              Container(width: 46, height: 1, color: Colors.white),
              Container(height: 1, color: Colors.grey)
            ],
          ) :
          Container(height: 1, color: Colors.white)
        ],
      )
    );
  }
}
