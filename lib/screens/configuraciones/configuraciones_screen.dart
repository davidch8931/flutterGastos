import 'package:flutter/material.dart';

import '../../models/configuraciones_model.dart';
import '../../repositories/configuraciones_repository.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({super.key});

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  final ConfiguracionRepository repo = ConfiguracionRepository();
  List<ConfiguracionesModel> configuraciones = [];
  bool cargando = true;

  //se ejecuta al cargar la pantalla
  @override
  void initState() {
    super.initState();
    cargarConfiguracion();
  }

  Future<void> cargarConfiguracion() async {
    setState(() => cargando = true);
    configuraciones = await repo.getAll();
    setState(() => cargando = false);
  }

  /*ELIMINAR*/
  void eliminarConfiguracion(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Eliminar Configuración"),
        content: Text("Estás seguro que desea eliminar este registro?"),
        actions: [
          TextButton(
            onPressed: () async {
              await repo.delete(id);
              Navigator.pop(context);
              cargarConfiguracion();
            },
            child: Text("Si"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listado de Configuración")),
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : configuraciones.isEmpty
          ? Center(child: Text("No existen datos"))
          :
            //permite construir a partir de datos
            ListView.builder(
              itemCount: configuraciones.length,
              itemBuilder: (context, i) {
                final conf = configuraciones[i];
                return Card(
                  child: ListTile(
                    title: Text(conf.monto),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              '/configuracion/form',
                              arguments: conf,
                            );
                            cargarConfiguracion();
                          },
                          icon: Icon(Icons.edit, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: configuraciones.isEmpty
        ? FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/configuracion/form');
              cargarConfiguracion();
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black,
            shape: CircleBorder(),
          )
        : null,
    );
  }
}
