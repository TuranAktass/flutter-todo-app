import 'package:todo_app/data_model/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDoDatabase {
  static final ToDoDatabase instance = ToDoDatabase._init();
  static Database? _database;

  ToDoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('database.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath!, filePath);

    //first version of database, 10/04/2021
    //v1-v2-v3 typecasting bugs
    return await openDatabase(path, version: 6, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableTodos(
      ${ToDoFields.id} $idType,
      ${ToDoFields.title} $textType,
      ${ToDoFields.text} $textType,
      ${ToDoFields.category} $textType,
      ${ToDoFields.createdAt} $textType,
      ${ToDoFields.isCompleted} $boolType,
      ${ToDoFields.isImportant} $boolType
    ) 
    ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<ToDo> create(ToDo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableTodos, todo.toJson());

    return todo.copy(id: id);
  }

  Future<ToDo> readTodo(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableTodos,
        columns: ToDoFields.values,
        where: '${ToDoFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ToDo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found!');
    }
  }

  Future<List<ToDo>> readAllTodos() async {
    final db = await instance.database;

    const orderBy = '${ToDoFields.createdAt} ASC';

    final result = await db.query(tableTodos, orderBy: orderBy);
    return result.map((json) => ToDo.fromJson(json)).toList();
  }

  Future<int> update(ToDo todo) async {
    final db = await instance.database;

    return db.update(tableTodos, todo.toJson(),
        where: '${ToDoFields.id} = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        // ignore: unnecessary_string_interpolations
        .delete(tableTodos, where: '${ToDoFields.id} = ?', whereArgs: [id]);
  }
}
