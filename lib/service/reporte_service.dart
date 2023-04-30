import 'dart:convert';
import 'package:proyecto_ps/models/reporte.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'https://apipr0yect.azurewebsites.net/api/reporte';

Future<List<ReporteModel>> loadReportebyid(int id) async {
  // ignore: prefer_interpolation_to_compose_strings
  final url = Uri.parse('$_baseUrl/' + id.toString());
  var resp = await http.get(url);
  var data = json.decode(resp.body);
  var reportes = <ReporteModel>[];
  for (var data in data) {
    reportes.add(ReporteModel.fromJson(data));
  }
  return reportes;
}

Future<List<ReporteModel>> loadReporte() async {
  final url = Uri.parse(_baseUrl);
  var resp = await http.get(url);
  var data = json.decode(resp.body);
  var reportes = <ReporteModel>[];
  for (var data in data) {
    reportes.add(ReporteModel.fromJson(data));
  }
  return reportes;
}

Future<String> postReporte(
    tipo, latitud, longitud, comentario, idUsuario, fecha) async {
  final url = Uri.parse(_baseUrl);
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'tipo': tipo,
    'latitud': latitud,
    'longitud': longitud,
    'comentario': comentario,
    'id_usuario': idUsuario,
    'fecha': fecha
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
