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
