import 'package:flutter/material.dart';

import '../../models/configuraciones_model.dart';
import '../../repositories/configuraciones_repository.dart';

class ConfiguracionFormScreen extends StatefulWidget {
  const ConfiguracionFormScreen({super.key});

  @override
  State<ConfiguracionFormScreen> createState() =>
      _ConfiguracionFormScreenState();
}

class _ConfiguracionFormScreenState extends State<ConfiguracionFormScreen> {
  final formConfiguracion = GlobalKey<FormState>();
  final montoController = TextEditingController();

  ConfiguracionesModel? configuracion;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      configuracion = args as ConfiguracionesModel;
      montoController.text = configuracion!.monto;
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEditar = configuracion != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ? "Editar Configuración" : "Nueva Configuración"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formConfiguracion,
          child: Column(
            children: [
              TextFormField(
                controller: montoController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El campo es requerido";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Monto",
                  hintText: "Ingrese el monto",
                  prefixIcon: Icon(Icons.settings, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (formConfiguracion.currentState!.validate()) {
                          final repo = ConfiguracionRepository();
                          final data = ConfiguracionesModel(
                            monto: montoController.text,
                          );

                          if (esEditar) {
                            data.id = configuracion!.id;
                            await repo.edit(data);
                          } else {
                            await repo.create(data);
                          }

                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Guardar"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Cancelar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
