// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../service/usuario_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController identificationController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    identificationController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);
    StylishDialog loading = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      style: DefaultStyle(
        progressColor: Theme.of(context).primaryColor,
      ),
      title: const Text('Cargando'),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate, es gratis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: identificationController,
                decoration: InputDecoration(
                  label: const Text('Identificación'),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: accentColor,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Se requiere la identificación'),
                ]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  label: const Text('Nombre'),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: accentColor,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Se requiere el nombre'),
                ]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  label: const Text('Apellido'),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: accentColor,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Se requiere apellido'),
                ]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  label: const Text('Correo electrónico'),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: accentColor,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: 'Se requiere correo electrónico'),
                  EmailValidator(errorText: 'Formato de correo inválido'),
                ]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  label: const Text('Teléfono'),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: accentColor,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Se requiere teléfono'),
                  PatternValidator(r'^[0-9]{10}$',
                      errorText: 'Formato de teléfono no válido (10 dígitos)'),
                ]),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  label: const Text('Contraseña'),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: accentColor,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Se requiere contraseña'),
                  MinLengthValidator(6,
                      errorText:
                          'La contraseña debe contener 6 caracteres como mínimo'),
                ]),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.only(
                        right: 75, left: 75, top: 15, bottom: 15),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loading.show();
                    final identificacion = identificationController.text;
                    final nombre = firstNameController.text;
                    final apellido = lastNameController.text;
                    final telefono = phoneController.text;
                    final correo = emailController.text;
                    final contra = passwordController.text;

                    final response = await registerUser(identificacion, nombre,
                        apellido, telefono, correo, contra);
                    loading.dismiss();
                    if (response != '') {
                      StylishDialog(
                        context: context,
                        alertType: StylishDialogType.SUCCESS,
                        title: const Text('Exito!'),
                        content: Text(response),
                        confirmButton: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          child: const Text('Continuar'),
                        ),
                      ).show();
                    } else {
                      StylishDialog(
                        context: context,
                        alertType: StylishDialogType.ERROR,
                        title: const Text('Error'),
                        content: const Text('Error al registar el usuario'),
                      ).show();
                    }
                    setState(() {
                      identificationController.clear();
                      firstNameController.clear();
                      lastNameController.clear();
                      phoneController.clear();
                      emailController.clear();
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
