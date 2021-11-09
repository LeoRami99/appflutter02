import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  @override
  InicioApp createState() => InicioApp();
}

class InicioApp extends State<Inicio> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
    );
  }
}