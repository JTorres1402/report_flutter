import 'dart:convert';
import 'package:proyecto_ps/models/usuario.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'apiproyectops.azurewebsites.net';
Future<List<UsuarioModel>> loadUsuiario() async {
  final url = Uri.http(_baseUrl, 'api/usuario');
  var resp = await http.get(url);
  var data = json.decode(resp.body);
  var usuario = <UsuarioModel>[];
  for (var data in data) {
    usuario.add(UsuarioModel.fromJson(data));
  }
  return usuario;
}
