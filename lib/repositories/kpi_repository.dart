import '../settings/database_connection.dart';

class KpiRepository {
  final database = DatabaseConnection();

  Future<double> totalIngresos() async {
    final db = await database.db;
    final result = await db.rawQuery('''
      SELECT IFNULL(SUM(CAST(monto AS REAL)), 0) total
      FROM transacciones
      WHERE tipo = 'ingreso'
    ''');
    return (result.first['total'] as num).toDouble();
  }

  Future<double> totalGastos() async {
    final db = await database.db;
    final result = await db.rawQuery('''
      SELECT IFNULL(SUM(CAST(monto AS REAL)), 0) total
      FROM transacciones
      WHERE tipo = 'gasto'
    ''');
    return (result.first['total'] as num).toDouble();
  }

  Future<double> balance() async {
    final db = await database.db;
    final result = await db.rawQuery('''
      SELECT IFNULL(
        SUM(
          CASE 
            WHEN tipo = 'ingreso' THEN CAST(monto AS REAL)
            WHEN tipo = 'gasto' THEN -CAST(monto AS REAL)
          END
        ), 0
      ) balance
      FROM transacciones
    ''');
    return (result.first['balance'] as num).toDouble();
  }
}