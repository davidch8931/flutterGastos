class ConfiguracionesModel {
  int? id;
  String monto;

  ConfiguracionesModel({this.id, required this.monto});

  factory ConfiguracionesModel.fromMap(Map<String, dynamic> data) {
    return ConfiguracionesModel(id: data["id"], monto: data["monto"]);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'monto': monto};
  }
}
