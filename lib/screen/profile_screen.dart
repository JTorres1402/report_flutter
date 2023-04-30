import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../service/usuario_service.dart';
import '../widget/circular_progess.dart';

class ProfileScreen extends StatefulWidget {
  final int id;
  const ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3e13b5),
        title: const Center(
          child: Text(
            'Perfil',
            style: TextStyle(fontSize: 27),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_outlined),
            tooltip: 'Cerrar sesion',
            onPressed: () {
              logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadUsuiariobyid(widget.id),
        builder: (context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
          // Usuario user = Usuario.fromJson(jsonEncode(snapshot));
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(child: Text('Algo salió mal'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: height * 0.28,
                      child: LayoutBuilder(
                        builder: (index, constraints) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${snapshot.data![0].nombre} ${snapshot.data![0].apellido}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 39,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Identificación:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          '${snapshot.data![0].idUsuario}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Teléfono:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          '${snapshot.data![0].telefono}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Correo:',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          snapshot.data![0].correo,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
