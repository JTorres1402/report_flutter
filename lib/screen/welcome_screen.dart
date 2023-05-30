import 'package:flutter/material.dart';

import '../widget/infocard.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Inicio',
            style: TextStyle(fontSize: 27),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
            child: InfoCard(
              title: "Bienvenido a SafeZone",
              body:
                  'Aquí puedes realizar informes de emergencia al instante, pruébalo es rápido y seguro 😉',
              subInfoTitle: 'Información adicional',
              subInfoText: 'Mas de 100 descargas',
              subIcon: Icon(Icons.download_outlined,
                  color: Theme.of(context).primaryColor, size: 45),
              onMoreTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
