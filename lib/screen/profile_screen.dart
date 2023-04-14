import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../service/usuario_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<UsuarioModel> _usuario = [];

  int i = 0;
  @override
  void initState() {
    super.initState();
    loadUsuiario().then((value) {
      setState(() {
        _usuario = value;
      });
    });
  }

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
        future: loadUsuiario(),
        builder: (context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
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
                              bottom: 0,
                              left: 0,
                              right: 0,
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
                                      height: 40,
                                    ),
                                    Text(
                                      '${_usuario[0].nombre} ${_usuario[0].apellido}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
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
                                              '${_usuario[i].idUsuario}',
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Column(
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
                                              '${_usuario[i].telefono}',
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
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




        // ListView.builder(
        //       itemCount: 1,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: ListTile(
        //             title: Text(snapshot.data![index].nombre),
        //             subtitle: Text(snapshot.data![index].apellido),
        //           ),
        //         );
        //       },
        //     );