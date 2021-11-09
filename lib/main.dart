import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Registro.dart';
import 'Inicio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
// primer Cambio ---
// segundo Cambio ---
// cambio 5
// cambio sobre branch app2
class Login extends StatefulWidget {
  @override
  LoginStart createState() => LoginStart();
}

class LoginStart extends State<Login> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();

  validarUser() async {
    try {
      CollectionReference referencia =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await referencia.get();

      if (usuario.docs.length != 0) {
        for (var cursor in usuario.docs) {
         // print(cursor.get("Correo"));
          if (cursor.get("Correo") == correo.text) {// validación de correo
            print("Correo encontrado -- " + cursor.get("nombre"));
            if (cursor.get("Password") == pass.text) {// validación de password
              Navigator.push(context, MaterialPageRoute(builder: (_)=> Inicio()));
            } else {
              print("usuario incorrecto");
            }
          } else {
            //print("Correo no encontrado");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Formulario Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/login_1.png'),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, top: 0, right: 15, bottom: 10),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo',
                  hintText: 'Digite Correo',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 10),
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Digite su contraseña',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () {
                        validarUser();
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Registro()));
                      },
                      child: Text(
                        'Registro',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
