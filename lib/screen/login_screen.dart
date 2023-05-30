// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_ps/screen/register_screen.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  late SharedPreferences _prefs;
  bool passToggle = true;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _setId(int id) {
    _prefs.setInt('id', id);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final StylishDialog loading = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      style: DefaultStyle(
        progressColor: Theme.of(context).primaryColor,
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
                height: (height * 15) / 100,
              ),
              Padding(
                padding: EdgeInsets.all((width * 3) / 100),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person_pin,
                            color: Theme.of(context).primaryColor,
                            size: 140,
                          ),
                          const Text(
                            "Iniciar sesión",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
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
                            child:
                                PasswordInput(inputController: passController),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'No tienes cuenta? ',
                                style: TextStyle(fontSize: 15),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Registrate aqui!',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: (height * 2) / 100,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor,
                              ),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.only(
                                    right: 75, left: 75, top: 15, bottom: 15),
                              ),
                            ),
                            onPressed: () async {
                              if (emailController.text.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                loading.show();
                                final user = emailController.text;
                                final pass = passController.text;
                                final response = await login(user, pass);
                                final personLogin = Persona.fromJson(
                                    jsonDecode(response.toString()));
                                if (personLogin.message == 'OK') {
                                  Navigator.pushNamed(context, "inicio");
                                  _setId(personLogin.id!);
                                } else {
                                  loading.dismiss();
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
                            child: const Padding(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                'Iniciar sesión',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
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
  final String message;
  final int? id;

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
