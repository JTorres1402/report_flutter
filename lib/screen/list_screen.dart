import 'package:flutter/material.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../models/reporte.dart';
import '../service/reporte_service.dart';

class ListReportScreen extends StatefulWidget {
  final int id;
  const ListReportScreen({super.key, required this.id});

  @override
  State<ListReportScreen> createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3e13b5),
        title: const Center(
          child: Text(
            'Reportes',
            style: TextStyle(fontSize: 27),
          ),
        ),
      ),
      body: FutureBuilder(
        future: loadReportebyid(widget.id),
        builder: (context, AsyncSnapshot<List<ReporteModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text('Algo salió mal'));
            }
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(snapshot.data![index].tipo),
                    onTap: () {
                      StylishDialog(
                        context: context,
                        alertType: StylishDialogType.NORMAL,
                        title: const Text('Detalles'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Tipo:',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  snapshot.data![index].tipo,
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Fecha de publicación:',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${snapshot.data![index].fecha}',
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Estado:',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  snapshot.data![index].estado,
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ],
                        ),
                      ).show();
                    },
                    subtitle: Text(snapshot.data![index].comentarios),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
