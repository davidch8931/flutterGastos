import 'package:flutter/material.dart';
import '../../repositories/kpi_repository.dart';

class KpiScreen extends StatefulWidget {
  const KpiScreen({super.key});

  @override
  State<KpiScreen> createState() => _KpiScreenState();
}

class _KpiScreenState extends State<KpiScreen> {
  final KpiRepository repo = KpiRepository();

  double ingresos = 0;
  double gastos = 0;
  double balance = 0;
  double montoInicial = 0;
  double montoActual = 0;

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarKpis();
  }

  Future<void> cargarKpis() async {
    setState(() => cargando = true);

    ingresos = await repo.totalIngresos();
    gastos = await repo.totalGastos();
    balance = await repo.balance();
    montoInicial = await repo.montoInicial();
    montoActual = await repo.montoActual();

    setState(() => cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("KPIs Financieros")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _kpiCard(
                    titulo: "Ingresos",
                    valor: ingresos,
                    color: Colors.green,
                    icono: Icons.arrow_upward,
                  ),
                  SizedBox(height: 15),
                  _kpiCard(
                    titulo: "Gastos",
                    valor: gastos,
                    color: Colors.red,
                    icono: Icons.arrow_downward,
                  ),
                  SizedBox(height: 15),
                  _kpiCard(
                    titulo: "Balance",
                    valor: balance,
                    color: balance >= 0 ? Colors.blue : Colors.orange,
                    icono: Icons.account_balance,
                  ),
                  SizedBox(height: 15),
                  _kpiCard(
                    titulo: "Monto Actual Disponible",
                    valor: montoActual,
                    color: montoActual >= 0 ? Colors.teal : Colors.red,
                    icono: Icons.account_balance_wallet,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: cargarKpis,
        child: Icon(Icons.refresh, color: Colors.white),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _kpiCard({
    required String titulo,
    required double valor,
    required Color color,
    required IconData icono,
  }) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icono, color: color, size: 35),
        title: Text(
          titulo,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "\$ ${valor.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
