
import 'package:flutter/material.dart';

class ContactCell extends StatefulWidget {
  final String letter;
  final String imageUrl;
  final String text;
  final bool isShowLetter;
  final bool hasLine;
  const ContactCell({Key? key, required this.imageUrl, required this.text, this.letter = '', this.isShowLetter = false, this.hasLine = true}) : super(key: key);

  @override
  State<ContactCell> createState() => _ContactCellState();
}

class _ContactCellState extends State<ContactCell> {
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
            //头部 letter
            widget.isShowLetter ?
            Container(
              height: 28,
              color: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1),
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.letter),
                  widget.letter == '☆' ? Row(
                    children: const [
                      SizedBox(width: 4),
                      Text('星标朋友',
                        style: TextStyle(
                          fontSize: 12
                        )
                      )
                    ]
                  ) : Container()
                ]
              )
            ) : Container(),
            //内部item
            Container(
              color: backColor,
              height: 46,
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                              image: widget.isShowLetter ?
                              DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(widget.imageUrl)
                              ) : DecorationImage(
                                  image: AssetImage(widget.imageUrl)
                              )
                          ),
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
                  ]
              ),
            ),

            widget.hasLine ?
            Row(
              children: [
                //两个Container都可以
                Container(width: 46, height: 1, color: Colors.white),
                Expanded(child: Container(height: 1, color: const Color.fromRGBO(0xe1, 0xe1, 0xe1, 1))),
              ],
            ) :
            Container(height: 1, color: Colors.white)
          ],
        ),
    );
  }
}
