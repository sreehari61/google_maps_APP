class UserModel {
  int id;
  String username;
  String password;
  User(String username,String password){
    this.username = username;
    this.password = password;
  }

  UserModel.fromMap(Map<String,dynamic> map){
    this.id = map['userId'];
    this.username = map['username'];
    this.password = map['password'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["username"] = this.username;
    data["password"] = this.password;
    return data;
  }
}