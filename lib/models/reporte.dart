import 'dart:convert';

List<ReporteModel> reporteModelFromJson(String str) => List<ReporteModel>.from(
    json.decode(str).map((x) => ReporteModel.fromJson(x)));

class ReporteModel {
  final int idReporte;
  final String tipo;
  final String comentarios;
  final String latitud;
  final String longitud;
  final String nombre;
  final String apellido;
  final int? telefono;
  final String? fecha;
  final String estado;

  ReporteModel(
      {required this.idReporte,
      required this.tipo,
      required this.comentarios,
      required this.latitud,
      required this.longitud,
      required this.nombre,
      required this.apellido,
      required this.telefono,
      required this.fecha,
      required this.estado});

  factory ReporteModel.fromJson(Map<String, dynamic> json) => ReporteModel(
      idReporte: json["id_reporte"],
      tipo: json["tipo"],
      comentarios: json["comentarios"],
      latitud: json["latitud"],
      longitud: json["longitud"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      telefono: json["telefono"],
      fecha: json["fecha"],
      estado: json["estado"]);
}
