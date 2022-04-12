
import 'package:flutter/material.dart';
import '../item_cell.dart';

class Mine extends StatelessWidget {
  const Mine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 12),
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("images/head.jpg")
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                )
                            ),
                            const SizedBox(width: 12),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("剪刀石头布",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text("微信号: rock666")
                                ]
                            )
                          ]
                      ),

                      Container(
                          margin: const EdgeInsets.only(left: 6),
                          child: Image.asset(
                            "images/icon_right.png",
                            width: 12,
                            height: 12,
                            fit: BoxFit.fitWidth,
                          )
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const ItemCell(imageUrl: "images/微信卡包.png", text: "卡包"),
                //也可以使用Container
                const SizedBox(height: 6),
                const ItemCell(imageUrl: "images/微信收藏.png", text: "shoucang ", hasLine: true),
                const ItemCell(imageUrl: "images/微信相册.png", text: "摇一摇", hasLine: true),
                const ItemCell(imageUrl: "images/微信表情.png", text: "看一看"),

                const SizedBox(height: 6),
                const ItemCell(imageUrl: "images/微信设置.png", text: "附近"),
              ],
            ),
          ),
          Container(
              height: 100,
              color: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1)
          )
        ],
      ),
    );
  }
}
