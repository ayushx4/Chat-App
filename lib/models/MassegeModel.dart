class MassegeModel{
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;

  MassegeModel({this.seen,this.sender,this.text,this.createdon});

  MassegeModel.fromMap(Map<String,dynamic> map){
    sender=map["sender"];
    text=map["text"];
    seen=map["seen"];
    createdon=map["createdon"].toDate();

  }

  Map<String,dynamic> toMap(){
    return {
      "sender" : sender,
      "text" : text,
      "seen" : seen,
      "createdon" : createdon
    };
  }
}