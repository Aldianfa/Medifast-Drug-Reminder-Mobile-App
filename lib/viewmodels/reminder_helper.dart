
import 'package:sqflite/sqflite.dart';
import 'package:uasmobile/models/reminder_info.dart';

final String tableReminder = 'reminder';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'reminderDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

final String tableName = 'reminder';

class ReminderHelper {
  static Database? _database;
  static ReminderHelper? _reminderHelper;

  ReminderHelper._createInstance();
  factory ReminderHelper() {
    if (_reminderHelper == null) {
      _reminderHelper = ReminderHelper._createInstance();
    }
    return _reminderHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "reminder.db";

    var database = openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        create table $tableReminder ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
      ''');
    });

    return database;
  }

  Future<void> insertReminder(ReminderInfo reminderInfo) async {
    var db = await this.database;
    var result = db.insert(tableReminder, reminderInfo.toMap());
    print('result : $result');
  }

  Future<List<ReminderInfo>> getReminders() async {
    List<ReminderInfo> _reminders = [];

    var db = await this.database;
    var result = await db.query(tableReminder);
    result.forEach((element) {
      var reminderInfo = ReminderInfo.fromMap(element);
      _reminders.add(reminderInfo);
    });

    return _reminders;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableReminder, where: '$columnId = ?', whereArgs: [id]);
  }
}
