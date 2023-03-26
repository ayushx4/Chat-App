class UserModel{
  String? uid;
  String? fullName;
  String? email;
  String? profilePic;
  String? mobileNumber;
  String? bio;

  UserModel({ this.uid,this.fullName,this.email,this.profilePic,this.mobileNumber,this.bio});

  UserModel.fromMap(Map<String,dynamic>  map){
    uid=map["uid"];
    fullName=map["fullName"];
    email=map["email"];
    profilePic=map["profilePic"];
    mobileNumber=map["mobileNumber"];
    bio=map["bio"];
  }

  Map<String,dynamic> toMap(){
    return {
      "uid" : uid,
      "fullName" : fullName,
      "email" : email,
      "profilePic" : profilePic,
      "mobileNumber" : mobileNumber,
      "bio" : bio
    };
}


}