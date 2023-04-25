import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_ps/service/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../widget/pass_input.dart';
import '../widget/user_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late SharedPreferences _prefs;
  bool passToggle = true;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _setId(int id) {
    _prefs.setInt('id', id);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StylishDialog loading = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      style: DefaultStyle(
        progressColor: const Color(0xff3e13b5),
      ),
      title: const Text('Cargando'),
    );
    return Scaffold(
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: (height * 10) / 100,
              ),
              Padding(
                padding: EdgeInsets.all((width * 3) / 100),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_pin,
                          color: Color.fromARGB(255, 15, 36, 153),
                          size: 140,
                        ),
                        SizedBox(
                          height: (height * 2) / 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: EmailInput(inputController: emailController),
                        ),
                        SizedBox(
                          height: (height * 1) / 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: PasswordInput(inputController: passController),
                        ),
                        SizedBox(
                          height: (height * 2) / 100,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(1, 1),
                                  colors: [
                                    Color(0xff5029ff),
                                    Color(0xff4b21e6),
                                    Color(0xff451acd),
                                    Color(0xff3e13b5),
                                    Color(0xff370d9d),
                                    Color(0xff2f0687),
                                    Color(0xff270271),
                                    Color(0xff1f005c),
                                  ])),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                alignment: Alignment.center,
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(
                                        right: 75,
                                        left: 75,
                                        top: 15,
                                        bottom: 15)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                )),
                            onPressed: () async {
                              if (emailController.text != '' &&
                                  passController.text != '') {
                                loading.show();
                                final user = emailController.text;
                                final pass = passController.text;
                                final reponse = await login(user, pass);
                                Persona personLogin =
                                    Persona.fromJson(jsonDecode(reponse));
                                if (personLogin.message == 'OK') {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamed(context, "inicio");
                                  _setId(personLogin.id!);
                                } else {
                                  loading.dismiss();
                                  // ignore: use_build_context_synchronously
                                  StylishDialog(
                                    context: context,
                                    alertType: StylishDialogType.ERROR,
                                    title: const Text('Error'),
                                    content: Text(personLogin.message),
                                  ).show();
                                }
                              } else {
                                StylishDialog(
                                  context: context,
                                  alertType: StylishDialogType.ERROR,
                                  title: const Text('Error'),
                                  content:
                                      const Text('Debes ingresar los datos'),
                                ).show();
                              }
                            },
                            child: const Text(
                              'Iniciar sesion',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Persona {
  String message;
  int? id;

  Persona({
    required this.message,
    this.id,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      message: json['message'],
      id: json['id'],
    );
  }
}
