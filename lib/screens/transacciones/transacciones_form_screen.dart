import 'package:flutter/material.dart';

import '../../models/transacciones_model.dart';
import '../../repositories/transacciones_repository.dart';

class FormTransacciones extends StatefulWidget {
  const FormTransacciones({super.key});

  @override
  State<FormTransacciones> createState() => _FormTransaccionesState();
}

class _FormTransaccionesState extends State<FormTransacciones> {
  final formKey = GlobalKey<FormState>();

  final montoController = TextEditingController();
  final descripcionController = TextEditingController();
  final fechaController = TextEditingController();

  String tipo = 'gasto'; // valor por defecto

  TransaccionesModel? trans;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      trans = args as TransaccionesModel;

      tipo = trans!.tipo;
      montoController.text = trans!.monto.toString();
      descripcionController.text = trans!.descripcion ?? '';
      fechaController.text = trans!.fecha;
    }
  }

  Future<void> seleccionarFecha() async {
    final seleccion = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (seleccion != null) {
      fechaController.text = seleccion.toIso8601String().split('T').first;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEditar = trans != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEditar ? 'Editar transacción' : 'Registrar transacción'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                value: tipo,
                items: const [
                  DropdownMenuItem(value: 'gasto', child: Text('Gasto')),
                  DropdownMenuItem(value: 'ingreso', child: Text('Ingreso')),
                ],
                onChanged: (value) {
                  tipo = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: montoController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese el monto';
                  if (double.tryParse(value) == null) return 'Monto inválido';
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Monto',
                  hintText: '0.00',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: fechaController,
                readOnly: true,
                onTap: seleccionarFecha,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Seleccione la fecha' : null,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: descripcionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Opcional',
                  prefixIcon: Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final repo = TransaccionesRepository();

                          final nueva = TransaccionesModel(
                            tipo: tipo,
                            fecha: fechaController.text,
                            monto: montoController.text,
                            descripcion: descripcionController.text,
                          );

                          if (esEditar) {
                            nueva.id = trans!.id;
                            await repo.edit(nueva);
                          } else {
                            await repo.create(nueva);
                          }

                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Aceptar'),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Cancelar'),
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
