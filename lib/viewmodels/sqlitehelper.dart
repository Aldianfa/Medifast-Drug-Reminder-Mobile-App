import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/obat.dart';

class SQLiteHelper {
  Future<Database> inisiasiDB() async {
    // membuka database dan menyimpan referensinya
    return openDatabase(
      // mengatur path database menggunakan fungsi join dari
      // paket 'path' untuk memastikan path dibuat dengan benar
      // untuk masing-masing platform.
      join(await getDatabasesPath(), 'kopi.db'),
      // ketika database dibuat, buat juga tabel untuk menyimpan data obat.
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE chart(id INTEGER PRIMARY KEY AUTOINCREMENT,' +  
          'name VARCHAR, price VARCHAR, description TEXT, image VARCHAR,'+
          'rate INTEGER, des VARCHAR)',
        );
      },
      // Atur versinya untuk melakukan upgrade atau downgrade database.
      version: 1,
    );
  }

  Future<void> insertObat(Obat obat) async {
    // Mendapatkan referensi ke database.
    final db = await inisiasiDB();
    // Insert data obat ke dalam tabel.
    await db.insert(
      'chart',
      obat.toMap(),
      // Jikq data obat yang di insert sebelumnya sudah ada
      // maka diganti dengan data sebelumnya
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method untuk mengambil data obat dari database
  Future<List<Obat>> ambilDataObat() async {
    // Mendapatkan referensi ke database
    final db = await inisiasiDB();
    // Query tabel untuk semua data obat.
    final List<Map<String, dynamic>> map = await db.query('chart');
    // Convert List<Map<String, dynamic>> ke list
    return List.generate(map.length, (i) {
      return Obat(
        id: map[i]['id'], name: map[i]['name'], price: map[i]['price'],
        description: map[i]['description'], image: map[i]['image'], rate:map[i]['rate'], 
        des: map[i]['des'],
      );
    });
  }

  // Method untuk menghapus data obat
  Future<void> deleteDataObat(int? id) async {
    // Mendapatkan referensi ke database
    final db = await inisiasiDB();
    // Hapus data obat dari database
    await db.delete('chart',
        // menggunakan 'where' untuk menghapus data obat tertentu
        where: 'id=?',
        // lewatkan id obat ke argumen 'whereArg' untuk menanggunalngi sql injection.
        whereArgs: [id]);
  }
}