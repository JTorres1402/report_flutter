import 'dart:convert';
import 'package:proyecto_ps/models/usuario.dart';
import 'package:http/http.dart' as http;

const _baseUrl = 'https://apipr0yect.azurewebsites.net/api';
// ignore: prefer_typing_uninitialized_variables
var messa;

Future<List<UsuarioModel>> loadUsuiario() async {
  final url = Uri.parse('$_baseUrl/usuario');
  var resp = await http.get(url);
  var data = json.decode(resp.body);
  var usuario = <UsuarioModel>[];
  for (var data in data) {
    usuario.add(UsuarioModel.fromJson(data));
  }
  return usuario;
}

Future<List<UsuarioModel>> loadUsuiariobyid(int id) async {
  // ignore: prefer_interpolation_to_compose_strings
  final url = Uri.parse('$_baseUrl/usuario/' + id.toString());
  var resp = await http.get(url);
  var data = json.decode(resp.body);
  var usuario = <UsuarioModel>[];
  for (var data in data) {
    usuario.add(UsuarioModel.fromJson(data));
  }
  return usuario;
}

Future login(id, pass) async {
  final url = Uri.parse('$_baseUrl/auth');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'user': id, 'password': pass});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    Map<String, dynamic> responseJson = {
      'message': responseData['message'],
      'id': responseData['id'],
    };
    String respon = jsonEncode(responseJson);
    return respon;
  } else {
    return messa;
  }
}
