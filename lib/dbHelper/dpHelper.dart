
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await intialDb();
    return _db!;
  }

  DatabaseHelper.internal();

  intialDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory(); //Path to a directory where the application may place data that is user-generated
    String path = p.join(documentDirectory.path, "quiz.db"); //Joins the documentDirectory path and database path into a single path
    var ourDb = await openDatabase(path, version: 2, onCreate: _onCreateDatabase, onUpgrade: _onUpgradeDatabase);
    return ourDb;
  }

  void _onCreateDatabase(Database db, int version) async { // Craete the new databse
    await db.execute("CREATE TABLE IF NOT EXISTS QuizApp(id INTEGER PRIMARY KEY autoincrement, quizName TEXT, type TEXT, correctAnswer INTEGER, incorrectAnswer INTEGER, skippedQuestion INTEGER )");
  }

  // UPGRADE DATABASE TABLES
  void _onUpgradeDatabase(Database db, int oldVersion, int newVersion) async { // Upgarde the Old Dtabase
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS QuizApp"); //execeute the the table into the databse
      _onCreateDatabase(db, newVersion);
    }
  }

  //insertion of Blog into Database
  Future<bool> saveBlog(String quizName, String type, int correctAnswer , int incorrectAnswer, int skippedQuestion) async {
    var dbClient = await db;
    Map<String, dynamic> values = new Map();
    var _results =  {
      'quizName': quizName,
      'type': type,
      'correctAnswer': correctAnswer,
      'incorrectAnswer':incorrectAnswer,
      'skippedQuestion':skippedQuestion
    };
    values.addAll(_results);
    int res = await dbClient.insert("QuizApp", values); // Insert the values into the Database
    return true;
  }


  //Update the Database
  Future<int> updateBlog(int id, String title, String descrption, String image) async {
    var dbClient = await db;
    final data = {'title': title, 'description': descrption, };
    if(image!=""){
      data.putIfAbsent("image", () => image);
    }

    final result = await dbClient.update('QuizApp', data, where: "id = ?", whereArgs: [id]); //update the item according to the unique id
    return result;
  }


  // Delete data from the Database
  Future<bool?> deleteBlogById(int id) async {
    var dbClient = await db;
    try {
      var response = await dbClient.delete("QuizApp", where: "id = ?", whereArgs: [id]); // Delete the data from the Database through unique id
      if (response == 1) {
        return true;
      } else
        false;
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }


  // Fetch the data from the database through id
  Future<List<Map<String, dynamic>>?> getSingleBlogByid(int id) async {
    var dbClient = await db;
    try {
      var result = await dbClient.query('QuizApp', where: "id = ?", whereArgs: [id], limit: 1);
      return result;
    } catch (e) {
      print(e);
    }
  }

  //Fetch all the data from the Database
  Future<List<Map<String, dynamic>>> getAllBlogs() async {
    var dbClient = await db;
    var data = await dbClient.query('QuizApp');
    return data;
  }
}
