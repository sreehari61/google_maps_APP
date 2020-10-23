
import 'package:google_maps/models/user.dart';

import 'db.dart';

class Auth{
  DBhelper dbHelper = DBhelper();

  Future<Map<String,dynamic>> signUp(String username, String password) async{
    var db = await dbHelper.db;
    if(username != '' || password != ''){
      try {
        var user = await db.rawQuery('SELECT username FROM tblUsers WHERE username = "$username"');
        if(user.length < 1){
          var res = await db.insert('tblUsers', {'username':username,'password':password});
          print(res);
          return {'type': "Success",'msg':'User inserted.'};
        }else{
          return {'type': "Error", 'msg':'Username already exits.'};
        }
      } catch (e) {
        print(e);
      }
    }
    return {'type': "Error",'msg':'Invalid credentials.'};
  }

  Future signIn(String username, String password) async{
    var db = await dbHelper.db;
    if(username != '' || password != ''){
      try {
        var maps = await db.rawQuery('SELECT * FROM tblUsers WHERE username = "$username" AND password = "$password"');
        if(maps.length > 0){
          List<UserModel> user = [];
          if(maps.length > 0){
            for(int i=0;i<maps.length; i++){
              user.add(UserModel.fromMap(maps[i]));
            }
          }
          return {'type': "Success",'user':user};
        }else{
          return {'type': "Error", 'msg':'No users found.'};
        }
      } catch (e) {
        print(e);
      }
    }
    return {'type': "Error",'msg':'Invalid credentials.'};
  }

}