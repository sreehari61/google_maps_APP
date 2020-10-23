import 'dart:io';

import 'package:flutter/material.dart';

import 'screens/mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // MyApp(){
  //   createDir();
  // }

  // createDir() async {
  //   Directory baseDir = await getExternalStorageDirectory();
  //   String databaseDir = "database";
  //   String databaseDirFinal = join(baseDir.path, databaseDir);
  //   var dir2 = Directory(databaseDirFinal);
  //   bool databasedirExists = await dir2.exists();
  //   if (!databasedirExists) {
  //     dir2.create(
  //         recursive: true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}
