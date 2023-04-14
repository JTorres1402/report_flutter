import 'package:flutter/material.dart';
import 'package:proyecto_ps/screen/screen.dart';

import '../widget/pass_input.dart';
import '../widget/show_message_widget.dart';
import '../widget/user_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool passToggle = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                activeColor: const Color(0xff3e13b5),
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                }),
                            const Text(
                              'Aceptar terminos',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
                            onPressed: () {
                              if (emailController.text != '' &&
                                  passController.text != '') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Bienvenido'),
                                    content: const Text('Datos corretos'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => {
                                          Navigator.pop(context, 'OK'),
                                          emailController.clear(),
                                          passController.clear(),
                                          isChecked = false,
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()),
                                          )
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const ShowMessage(
                                    title: 'Error',
                                    content: 'Debes ingresar los datos',
                                  ),
                                );
                              }
                              if (!isChecked) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const ShowMessage(
                                    title: 'Error',
                                    content: 'Debes aceptar los terminos',
                                  ),
                                );
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
