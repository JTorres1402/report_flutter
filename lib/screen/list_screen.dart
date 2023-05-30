import 'package:flutter/material.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../models/reporte.dart';
import '../service/reporte_service.dart';
import '../widget/circular_progess.dart';

class ListReportScreen extends StatefulWidget {
  final int id;

  const ListReportScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ListReportScreen> createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Reportes',
            style: TextStyle(fontSize: 27),
          ),
        ),
      ),
      body: FutureBuilder<List<ReporteModel>>(
        future: loadReportebyid(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final reporte = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(reporte.tipo),
                      onTap: () {
                        _showReportDetails(reporte);
                      },
                      subtitle: Text(reporte.comentarios),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Algo salió mal'));
            }
          }
          return Center(
            child: DottedCircularProgressIndicatorFb(
              size: 30,
              numDots: 9,
              dotSize: 3,
              defaultDotColor: Theme.of(context).primaryColor,
              currentDotColor: Colors.orange,
              secondsPerRotation: 1,
            ),
          );
        },
      ),
    );
  }

  /// Muestra los detalles del reporte en un diálogo elegante.
  void _showReportDetails(ReporteModel reporte) {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.NORMAL,
      title: const Text('Detalles'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Tipo:', reporte.tipo),
          _buildDetailRow('Fecha de publicación:', reporte.fecha ?? ''),
          _buildDetailRow('Estado:', reporte.estado),
        ],
      ),
    ).show();
  }

  /// Construye una fila de detalles en el diálogo.
  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
