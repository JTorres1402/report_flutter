import 'package:flutter/material.dart';

import '../models/reporte.dart';
import '../service/reporte_service.dart';

class ListReportScreen extends StatelessWidget {
  const ListReportScreen({super.key});

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
        future: loadReporte(),
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
