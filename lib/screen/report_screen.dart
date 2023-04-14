import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proyecto_ps/blocs/gps/gps_bloc.dart';
import 'package:proyecto_ps/screen/gps_access_screen.dart';
import 'package:proyecto_ps/service/reporte_service.dart';

import '../widget/show_message_widget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  final TextEditingController _controllerCometario = TextEditingController();

  List<String> items = ['Robo', 'Accidente', 'Incendio'];

  String? selectItem = 'Robo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Nuevo reporte',
            style: TextStyle(fontSize: 27),
          ),
        ),
      ),
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tipo de reporte',
                            ),
                            value: selectItem,
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                    value: item, child: Text(item)))
                                .toList(),
                            onChanged: (item) => setState(
                                  () => selectItem = item,
                                )),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _controllerCometario,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Comentario',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(15),
                          color: Colors.blue,
                          shape: const StadiumBorder(),
                          child: const Text(
                            'Enviar reporte',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () async {
                            if (_controllerCometario.text != '') {
                              Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                              final value = _controllerCometario.text;
                              final longitud = position.longitude;
                              final latitud = position.latitude;
                              const usu = 41;
                              postReporte(selectItem, latitud, longitud, value, usu);
                              final  reponse = await postReporte(selectItem, latitud, longitud, value, usu);
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => ShowMessage(
                                  title: 'Enviado',
                                  content: reponse,
                                ),
                              );
                              setState(() {
                              selectItem = items.first;
                              _controllerCometario.clear();
                            });
                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => const ShowMessage(
                                  title: 'Error',
                                  content: 'Debes ingresar el comentario',
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              : const GpsAccessScreen();
        },
      ),
    );
  }
}
