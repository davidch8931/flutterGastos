import 'package:gastitosec/models/transacciones_model.dart';

import '../settings/database_connection.dart';

class TransaccionesRepository {
  final tableName = "transacciones";
  final database = DatabaseConnection();

  //crear datos
  Future<int> create(TransaccionesModel data) async {
    final db = await database.db; //1.llamar a la conexion
    return await db.insert(tableName, data.toMap()); //2. ejecuto el sql
  }

  //editar datos
  Future<int> edit(TransaccionesModel data) async {
    final db = await database.db; //1.llamar a la conexion
    return await db.update(
      tableName,
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    ); //2. ejecuto el sql
  }

  //eliminar datos
  Future<int> delete(int id) async {
    final db = await database.db; //1.llamar a la conexion
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    ); //2. ejecuto el sql
  }

  //listado
  Future<List<TransaccionesModel>> getAll() async {
    final db = await database.db;
    final response = await db.query(tableName);
    return response.map((e) => TransaccionesModel.fromMap(e)).toList();
  }
}
