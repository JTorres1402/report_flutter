// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_ps/blocs/gps/gps_bloc.dart';
import 'package:proyecto_ps/screen/gps_access_screen.dart';
import 'package:proyecto_ps/service/reporte_service.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class ReportScreen extends StatefulWidget {
  final int id;
  const ReportScreen({super.key, required this.id});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _controllerCometario = TextEditingController();

  List<String> items = ['Robo', 'Accidente', 'Incendio'];

  String? selectItem = 'Robo';

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff3e13b5);
    const accentColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    StylishDialog loading = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      style: DefaultStyle(
        progressColor: const Color(0xff3e13b5),
      ),
      title: const Text('Cargando'),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3e13b5),
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
                              labelText: 'Tipo de reporte',
                              labelStyle: TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: accentColor,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: secondaryColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: errorColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
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
                        TextField(
                          controller: _controllerCometario,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Comentario',
                            labelStyle: TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: accentColor,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: errorColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(15),
                          color: const Color(0xff3e13b5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: const Text(
                            'Enviar reporte',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () async {
                            if (_controllerCometario.text != '') {
                              var now = DateTime.now();
                              var formatter = DateFormat("dd/MM/yyyy");
                              String date = formatter.format(now);
                              loading.show();
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              final value = _controllerCometario.text;
                              final longitud = position.longitude;
                              final latitud = position.latitude;
                              var usu = widget.id;
                              final reponse = await postReporte(selectItem,
                                  latitud, longitud, value, usu, date);

                              if (reponse != '') {
                                loading.dismiss();
                                StylishDialog(
                                  context: context,
                                  alertType: StylishDialogType.SUCCESS,
                                  title: const Text('Enviado'),
                                  content: Text(reponse),
                                ).show();
                              } else {
                                loading.dismiss();
                                StylishDialog(
                                  context: context,
                                  alertType: StylishDialogType.ERROR,
                                  title: const Text('Error'),
                                  content:
                                      const Text('Error al enviar el reporte'),
                                ).show();
                              }
                              setState(() {
                                selectItem = items.first;
                                _controllerCometario.clear();
                              });
                            } else {
                              StylishDialog(
                                context: context,
                                alertType: StylishDialogType.ERROR,
                                title: const Text('Error'),
                                content:
                                    const Text('Debes ingresar el comentario'),
                              ).show();
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
