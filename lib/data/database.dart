import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String QuizNum = 'quiz_num';
  static const String QuizQuestion = 'question';
  static const String QuizAnswerCorrect = 'correct_answer';
  static const String TABLE = 'quiz';
  static const String DB_NAME = 'quiz.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $QuizNum TEXT, $QuizQuestion TEXT, $QuizAnswerCorrect TEXT)");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS $TABLE");
      _onCreate(db, newVersion);
    }
  }

  Future<Quiz> save(Quiz quiz) async {
    var dbClient = await db;
    quiz.id = await dbClient.insert(TABLE, quiz.toMap());
    return quiz;
  }

  Future<List<Quiz>> getQuiz() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(TABLE, columns: [ID, QuizNum, QuizQuestion, QuizAnswerCorrect]);
    List<Quiz> quiz = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        quiz.add(Quiz.fromMap(maps[i]));
      }
    }
    return quiz;
  }

  Future<int> delete() async {
    var dbClient = await db;
    return await dbClient.delete(TABLE);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}