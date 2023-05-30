import 'dart:convert';
import 'package:proyecto_ps/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _baseUrl = 'https://apipr0yect.azurewebsites.net/api';
// ignore: prefer_typing_uninitialized_variables
var messa;
var storage = const FlutterSecureStorage();

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

Future<String> registerUser(
    identificacion, nombre, apellido, telefono, correo, contrasena) async {
  final url = Uri.parse('$_baseUrl/usuario');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'id_usuario': identificacion,
    'nombre': nombre,
    'apellido': apellido,
    'telefono': telefono,
    'correo': correo,
    'contrasena': contrasena,
  });

  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    final responseData = jsonDecode(response.body);
    return responseData;
  }
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

Future loadUsuario(int id) async {
  // ignore: prefer_interpolation_to_compose_strings
  final url = Uri.parse('$_baseUrl/usuario/' + id.toString());
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);

    Map<String, dynamic> responseJson = {
      'identi': responseData[0]['id_usuario'],
      'nombre': responseData[0]['nombre'],
    };

    await storage.write(
        key: 'identificacion', value: responseData[0]['id_usuario']);
    await storage.write(key: 'nombre', value: responseData[0]['nombre']);
    await storage.write(key: 'apellido', value: responseData[0]['apellido']);
    await storage.write(key: 'correo', value: responseData[0]['correo']);
    await storage.write(key: 'telefono', value: responseData[0]['telefono']);

    String respon = jsonEncode(responseJson);
    return respon;
  }
  return messa;
}

Future login(id, pass) async {
  final url = Uri.parse('$_baseUrl/auth');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'user': id, 'password': pass});
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print(jsonDecode(response.body));
    Map<String, dynamic> responseJson = {
      'message': responseData['message'],
      'id': responseData['id'],
    };

    await storage.write(key: 'token', value: responseData['token']);

    String respon = jsonEncode(responseJson);
    return respon;
  } else {
    return messa;
  }
}

Future<String> readToken() async {
  return await storage.read(key: 'token') ?? '';
}

Future logout() async {
  await storage.deleteAll();
  return;
}
