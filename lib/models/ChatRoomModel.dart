
class ChatRoomModel {
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  DateTime? createdonChatroomModel;
  List<dynamic>? usersList;

  ChatRoomModel({this.chatRoomId,this.participants, this.lastMessage,  required this.createdonChatroomModel,this.usersList});

  ChatRoomModel.fromMap(Map<String,dynamic> map){
    chatRoomId=map["chatRoomId"];
    participants=map["participants"];
    lastMessage=map["lastMessage"];
    createdonChatroomModel=map["createdonChatroomModel"].toDate();
    usersList =map["userList"];
  }

  Map<String,dynamic> toMap(){
    return{
      "chatRoomId" : chatRoomId,
      "participants" : participants,
      "lastMessage" : lastMessage,
      "createdonChatroomModel" : createdonChatroomModel,
      "usersList" : usersList
    };
  }

}