
class ChatListData {
  final String imgUrl;
  final String name;
  final String message;

  ChatListData({required this.imgUrl, required this.name, required this.message});

  factory ChatListData.formJson(Map<String, dynamic> json) {
    return ChatListData(
        imgUrl: json["imageUrl"],
        name: json['name'],
        message: json['message']);
  }
}


