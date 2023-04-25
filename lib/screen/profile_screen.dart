import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../service/usuario_service.dart';

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
              padding: const EdgeInsets.symmetric(vertical: 140),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (index, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      snapshot.data![0].nombre,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Identificacion',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${snapshot.data![0].idUsuario}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Telefono',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${snapshot.data![0].telefono}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Correo',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.data![0].correo,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Image.asset(
                                  'images/profile1.png',
                                  width: innerWidth * 0.45,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
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

class Usuario {
  String nombre;
  String apellido;
  int id;
  String correo;
  int telefono;
  String rol;

  Usuario(
      {required this.nombre,
      required this.apellido,
      required this.id,
      required this.correo,
      required this.telefono,
      required this.rol});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombre: json['nombre'],
      apellido: json['apellido'],
      id: json['id_usuario'],
      correo: json['correo'],
      telefono: json['telefono'],
      rol: json['rol'],
    );
  }
}
