import 'package:google_maps/models/marker.dart';

import 'db.dart';

class MarkerDb {
  DBhelper dbHelper = DBhelper();

  Future addMarker(double lat, double lng, int userId) async {
    var db = await dbHelper.db;
    try {
      var res = db.insert('tblMarkers', {'latitude': lat, 'longitude': lng, 'userId': userId});
      return res;
    } catch (e) {
      print(e);
    }
  }

  Future getMarkers(int id) async {
    var db = await dbHelper.db;
    try {
      var maps =
          await db.rawQuery('SELECT * FROM tblMarkers WHERE userId = "$id"');
      List<MarkerModel> markers = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          markers.add(MarkerModel.fromMap(maps[i]));
        }
      }
      return markers;
    } catch (e) {
      print(e);
    }
  }

  updateMarker(double lat, double lng, int markerId)async{
    var db = await dbHelper.db;
    try {
      db.update('tblMarkers', {'latitude': lat, 'longitude': lng}, where: "markerId = $markerId");
    } catch (e) {
      print(e);
    }
  }

  deleteAll()async{
    var db = await dbHelper.db;
    try {
      db.rawQuery('DELETE * FROM tblMarkers');
    } catch (e) {
      print(e);
    }
  }

  deleteMarker(int id)async{
    var db = await dbHelper.db;
    try {
      db.rawQuery('DELETE FROM tblMarkers WHERE markerId = $id');
    } catch (e) {
      print(e);
    }
  }

}
