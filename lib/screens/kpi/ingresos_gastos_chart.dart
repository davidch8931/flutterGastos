import 'package:flutter/material.dart';

class IngresosGastosChart extends StatelessWidget {
  final double ingresos;
  final double gastos;

  const IngresosGastosChart({
    super.key,
    required this.ingresos,
    required this.gastos,
  });

  @override
  Widget build(BuildContext context) {
    final double maxValor = ingresos > gastos ? ingresos : gastos;

    final double ingresoAltura = maxValor == 0
        ? 0.0
        : (ingresos / maxValor).toDouble();

    final double gastoAltura = maxValor == 0
        ? 0.0
        : (gastos / maxValor).toDouble();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Ingresos vs Gastos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _barra("Ingresos", ingresoAltura, Colors.green),
                SizedBox(width: 20),
                _barra("Gastos", gastoAltura, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _barra(String label, double altura, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 120 * altura,
            width: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
