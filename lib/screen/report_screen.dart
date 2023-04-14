import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_ps/blocs/gps/gps_bloc.dart';
import 'package:proyecto_ps/screen/gps_access_screen.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final TextEditingController _controller = TextEditingController();

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
                      mainAxisAlignment: MainAxisAlignment.values[02],
                      children: [
                        TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                          onPressed: () {},
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
