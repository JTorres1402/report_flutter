import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_ps/blocs/gps/gps_bloc.dart';
import 'package:proyecto_ps/models/reporte.dart';
import 'package:proyecto_ps/screen/gps_access_screen.dart';
import 'package:proyecto_ps/service/reporte_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widget/circular_progess.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.963587998299452, -74.84062602006323),
    zoom: 10,
  );
  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Uint8List? markerImage;
  final List<Marker> _markers = <Marker>[];
  late List<ReporteModel> _reportes = [];

  @override
  void initState() {
    super.initState();
    loadReporte().then((value) {
      setState(() {
        _reportes = value;
      });
      loadData();
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  String urlImg = '';

  loadData() async {
    if (_reportes.isNotEmpty) {
      for (var i = 0; i < _reportes.length; i++) {
        switch (_reportes[i].tipo) {
          case 'Robo':
            urlImg = 'images/marker_1.png';
            break;
          case 'Accidente':
            urlImg = 'images/marker_2.png';
            break;
          case 'Incendio':
            urlImg = 'images/marker_3.png';
            break;
          default:
        }

        final Uint8List markerIcon = await getBytesFromAsset(urlImg, 100);
        _markers.add(
          Marker(
            markerId: MarkerId(_reportes[i].idReporte.toString()),
            position: LatLng(double.parse(_reportes[i].latitud),
                double.parse(_reportes[i].longitud)),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
                title: _reportes[i].tipo, snippet: _reportes[i].comentarios),
          ),
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3e13b5),
        title: const Center(
          child: Text(
            'Mapa de reportes',
            style: TextStyle(fontSize: 27),
          ),
        ),
      ),
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
              ? FutureBuilder(
                  future: loadReporte(),
                  builder:
                      (context, AsyncSnapshot<List<ReporteModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        return const Center(child: Text('Algo salió mal'));
                      }
                      return SafeArea(
                        child: GoogleMap(
                          initialCameraPosition: Maps._kGooglePlex,
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          markers: Set<Marker>.of(_markers),
                        ),
                      );
                    }
                    return const Center(
                        child: DottedCircularProgressIndicatorFb(
                      size: 30,
                      numDots: 9,
                      dotSize: 3,
                      defaultDotColor: Color(0xff3e13b5),
                      currentDotColor: Colors.orange,
                      secondsPerRotation: 1,
                    ));
                  },
                )
              : const GpsAccessScreen();
        },
      ),
    );
  }
}
