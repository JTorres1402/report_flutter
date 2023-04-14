import 'dart:convert';
import 'package:proyecto_ps/models/reporte.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'apiproyectops.azurewebsites.net';
Future<List<ReporteModel>> loadReporte() async {
  final url = Uri.http(_baseUrl, 'api/reporte');
  var resp = await http.get(url);
  var data = json.decode(resp.body);
  var reportes = <ReporteModel>[];
  for (var data in data) {
    reportes.add(ReporteModel.fromJson(data));
  }
  return reportes;
}

Future<String> postReporte(tipo, latitud, longitud, comentario, idUsuario) async {
  final url = Uri.parse('https://apiproyectops.azurewebsites.net/api/reporte'); 
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'tipo': tipo, 'latitud': latitud, 'longitud': longitud, 'comentario': comentario, 'id_usuario': idUsuario});
  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    final responseData = jsonDecode(response.body);
    return responseData ;
  }
}
