import '../models/configuraciones_model.dart';
import '../settings/database_connection.dart';

class ConfiguracionRepository {
  final tableName = "configuracion";
  final database = DatabaseConnection();

  //crear
  Future<int> create(ConfiguracionesModel data) async {
    final db = await database.db;
    return await db.insert(tableName, data.toMap());
  }

  //editar
  Future<int> edit(ConfiguracionesModel data) async {
    final db = await database.db;
    return await db.update(
      tableName,
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  //eliminar
  Future<int> delete(int id) async {
    final db = await database.db;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  //listar
  Future<List<ConfiguracionesModel>> getAll() async {
    final db = await database.db;
    final response = await db.query(tableName);
    return response.map((e) => ConfiguracionesModel.fromMap(e)).toList();
  }
}
