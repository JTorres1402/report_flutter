import 'dart:convert';
import 'package:proyecto_ps/models/reporte.dart';
import 'package:http/http.dart' as http;

// URL base para las peticiones HTTP
String _baseUrl = 'https://apipr0yect.azurewebsites.net/api/reporte';

// Carga los reportes filtrados por ID
Future<List<ReporteModel>> loadReportebyid(int id) async {
  // Construye la URL completa concatenando el ID proporcionado
  final url = Uri.parse('$_baseUrl/$id');

  // Realiza una solicitud GET a la URL y obtiene la respuesta
  var resp = await http.get(url);

  // Decodifica la respuesta JSON en un objeto Dart
  var data = json.decode(resp.body);

  // Crea una lista de objetos ReporteModel vacía
  var reportes = <ReporteModel>[];

  // Itera sobre los datos decodificados y crea objetos ReporteModel a partir de ellos
  for (var dataItem in data) {
    reportes.add(ReporteModel.fromJson(dataItem));
  }

  // Devuelve la lista de reportes
  return reportes;
}

// Carga todos los reportes
Future<List<ReporteModel>> loadReporte() async {
  // Construye la URL completa para cargar todos los reportes
  final url = Uri.parse(_baseUrl);

  // Realiza una solicitud GET a la URL y obtiene la respuesta
  var resp = await http.get(url);

  // Decodifica la respuesta JSON en un objeto Dart
  var data = json.decode(resp.body);

  // Crea una lista de objetos ReporteModel vacía
  var reportes = <ReporteModel>[];

  // Itera sobre los datos decodificados y crea objetos ReporteModel a partir de ellos
  for (var dataItem in data) {
    reportes.add(ReporteModel.fromJson(dataItem));
  }

  // Devuelve la lista de reportes
  return reportes;
}

// Envía un reporte al servidor
Future<String> postReporte(
    tipo, latitud, longitud, comentario, idUsuario, fecha) async {
  // Construye la URL completa para enviar el reporte
  final url = Uri.parse(_baseUrl);

  // Configura las cabeceras de la solicitud HTTP
  final headers = {'Content-Type': 'application/json'};

  // Convierte los datos del reporte en un JSON codificado
  final body = jsonEncode({
    'tipo': tipo,
    'latitud': latitud,
    'longitud': longitud,
    'comentario': comentario,
    'id_usuario': idUsuario,
    'fecha': fecha
  });

  // Realiza una solicitud POST a la URL con las cabeceras y el cuerpo proporcionados
  final response = await http.post(url, headers: headers, body: body);

  // Comprueba el código de estado de la respuesta para determinar el resultado
  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, decodifica el cuerpo de la respuesta y lo devuelve
    final responseData = jsonDecode(response.body);
    return responseData;
  } else {
    // Si la respuesta no es exitosa, decodifica el cuerpo de la respuesta y lo devuelve
    final responseData = jsonDecode(response.body);
    return responseData;
  }
}
