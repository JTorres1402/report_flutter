import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../service/usuario_service.dart';
import '../widget/circular_progess.dart';

/// Pantalla que muestra el perfil de un usuario.
class ProfileScreen extends StatefulWidget {
  /// ID del usuario.
  final int id;

  /// Constructor de la clase ProfileScreen.
  const ProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Perfil de Usuario',
            style: TextStyle(fontSize: 27),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_outlined),
            tooltip: 'Cerrar sesión',
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
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              // Si no se pudo cargar la información del usuario, muestra un mensaje de error.
              return const Center(child: Text('Algo salió mal'));
            }
            return Container(
              padding: const EdgeInsets.all(20),
              child: LayoutBuilder(builder: (index, constraints) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nombre:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                // Muestra el nombre y apellido del usuario.
                                '${snapshot.data![0].nombre} ${snapshot.data![0].apellido}',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Identificación:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                // Muestra la identificación del usuario.
                                '${snapshot.data![0].idUsuario}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Teléfono:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                // Muestra el teléfono del usuario.
                                '${snapshot.data![0].telefono}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Correo electrónico:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                // Muestra el correo electrónico del usuario.
                                snapshot.data![0].correo,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            );
          }
          // Muestra un indicador de progreso mientras se carga la información del usuario.
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
}
