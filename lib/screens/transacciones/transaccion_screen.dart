import 'package:flutter/material.dart';
import '../../models/transacciones_model.dart';
import '../../repositories/transacciones_repository.dart';

class ListaTransaccion extends StatefulWidget {
  const ListaTransaccion({super.key});

  @override
  State<ListaTransaccion> createState() => _ListaTransaccionState();
}

class _ListaTransaccionState extends State<ListaTransaccion> {
  final TransaccionesRepository repo = TransaccionesRepository();
  List<TransaccionesModel> trans = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarTransacciones();
  }

  Future<void> cargarTransacciones() async {
    setState(() => cargando = true);
    trans = await repo.getAll();
    setState(() => cargando = false);
  }

  Future<void> eliminarTransaccion(int id) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar transacción'),
        content: Text('¿Está seguro de eliminar esta transacción?'),
        actions: [
          TextButton(
            onPressed: () async {
              await repo.delete(id);
              Navigator.pop(context);
              cargarTransacciones();
            },
            child: Text('Si'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacciones'),
        backgroundColor: Colors.blue,
      ),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : trans.isEmpty
              ? Center(child: Text('No existen transacciones'))
              : ListView.builder(
                  itemCount: trans.length,
                  itemBuilder: (context, i) {
                    final t = trans[i];
                    return Card(
                      child: ListTile(
                        title: Text('${t.tipo.toUpperCase()} - \$${t.monto}'),
                        subtitle: Text('${t.fecha}\n${t.descripcion ?? ''}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await Navigator.pushNamed(
                                  context,
                                  '/transacciones/form',
                                  arguments: t,
                                );
                                cargarTransacciones();
                              },
                              icon: Icon(Icons.edit, color: Colors.orange),
                            ),
                            IconButton(
                              onPressed: () => eliminarTransaccion(t.id!),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/transacciones/form');
          cargarTransacciones();
        },
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: Icon(Icons.add_circle_outlined, color: Colors.white),
      ),
    );
  }
}
