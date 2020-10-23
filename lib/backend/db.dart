import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';


class DBhelper{
  static Database _db;
  Future<Database> get db async {
    if(_db != null){
        return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async{
    String path = join(await getDatabasesPath(),"database.db");
    var db = await openDatabase(path,version:1,onCreate:_onCreate,onConfigure: _onConfigure);
    return db;
  }

  static Future _onConfigure(Database db) async{
    await db.execute('PRAGMA foreign_keys = ON');
  } 

  static Future  _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE tblUsers (userId INTEGER PRIMARY KEY AUTOINCREMENT,username VARCHAR (2000) NOT NULL,password VARCHAR (2000) NOT NULL)");
    await db.execute("CREATE TABLE tblMarkers (markerId INTEGER PRIMARY KEY AUTOINCREMENT,latitude DOUBLE NOT NULL, longitude DOUBLE NOT NULL, userId INT NOT NULL, FOREIGN KEY (userId) REFERENCES tblUsers (userId))");
    // await db.execute("CREATE TABLE tblCategory (Categoryid INTEGER PRIMARY KEY AUTOINCREMENT,CategoryType INTEGER NOT NULL,CategoryName VARCHAR (2000) NOT NULL,CreatedDate DATE NOT NULL,UpdatedDate DATE NOT NULL,status INTEGER (2) NOT NULL)");
    // await db.execute("CREATE TABLE tblExpenseDetails (Expenseid INTEGER PRIMARY KEY AUTOINCREMENT, Amount DOUBLE NOT NULL, Date DATE NOT NULL, Account VARCHAR(50) NULL, ExpenseType INT NOT NULL, Category INTEGER NULL, Expfrom VARCHAR(250) NULL, Expto VARCHAR(250) NULL, Description VARCHAR(250) NOT NULL, Memo VARCHAR(250) NULL,ImagePath TEXT NULL, FOREIGN KEY (Category) REFERENCES tblCategory (Categoryid) )");
    // await db.execute("CREATE TABLE tblNote (Noteid INTEGER PRIMARY KEY AUTOINCREMENT, Title VARCHAR(2000) NOT NULL,Note VARCHAR(8000) NOT NULL, Date DATE NOT NULL, Category INTEGER NOT NULL, Starred INTEGER (2), FOREIGN KEY (Category) REFERENCES tblNoteCategory (Notecategoryid))");
    // await db.execute("CREATE TABLE tblNoteCategory (Notecategoryid INTEGER PRIMARY KEY AUTOINCREMENT, Categorytitle VARCHAR(2000) NOT NULL, Color INTEGER NOT NULL)");
  }
}