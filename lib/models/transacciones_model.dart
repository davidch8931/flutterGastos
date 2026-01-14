class TransaccionesModel {
  int? id;
  String tipo;
  String fecha;
  String monto;
  String? descripcion;

  TransaccionesModel({
    this.id,
    required this.tipo,
    required this.fecha,
    required this.monto,
    this.descripcion,
  });

  factory TransaccionesModel.fromMap(Map<String, dynamic> data) {
    return TransaccionesModel(
      id: data["id"],
      tipo: data["tipo"],
      fecha: data["fecha"],
      monto: data["monto"],
      descripcion: data["descripcion"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'fecha': fecha,
      'monto': monto,
      'descripcion': descripcion,
    };
  }
}
