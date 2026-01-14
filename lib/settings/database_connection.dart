import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  // Generando un constructor para el llamado (Singleton)
  static final DatabaseConnection instance = DatabaseConnection.internal();
  factory DatabaseConnection() => instance;

  // Referencias internas
  DatabaseConnection.internal();

  // Crear un llamado a la libreria sqflite
  // Permite anular los nulos ?
  static Database? database;

  // Función para crear la conexion
  Future<Database> get db async {
    // Conexión a la BDD
    if (database != null) return database!;
    database = await inicializarDb(); // Inicializa la conexion en la funcion
    return database!; // Retorna la conexion con la nueva conexion
  }

  Future<Database> inicializarDb() async {
    final rutaDb = await getDatabasesPath(); // data/data/com.app/databases
    final rutaFinal = join(
      rutaDb,
      'finanzas.db',
    ); // data/data/com.app/databases/finanzas.db

    return await openDatabase(
      rutaFinal,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE configuracion (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            monto DECIMAL NOT NULL DEFAULT 0.0
          )
        ''');

        // Insertar registro inicial con monto 0
        await db.insert('configuracion', {'monto': 0.0});

        await db.execute('''
          CREATE TABLE transacciones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tipo TEXT NOT NULL,
            fecha TEXT NOT NULL,
            monto DECIMAL NOT NULL,
            descripcion TEXT
          )
        ''');
      },
    );
  }
}
