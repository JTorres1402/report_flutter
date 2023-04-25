import 'dart:convert';

List<UsuarioModel> usuarioModelFromJson(String str) => List<UsuarioModel>.from(
    json.decode(str).map((x) => UsuarioModel.fromJson(x)));

class UsuarioModel {
  final int idUsuario;
  final String nombre;
  final String correo;
  final String apellido;
  final int telefono;

  UsuarioModel({
    required this.idUsuario,
    required this.nombre,
    required this.correo,
    required this.apellido,
    required this.telefono,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUsuario: json["id_usuario"],
        nombre: json["nombre"],
        correo: json["correo"],
        apellido: json["apellido"],
        telefono: json["telefono"],
      );
}
