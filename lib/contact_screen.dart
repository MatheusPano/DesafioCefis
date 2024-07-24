import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 8, 171, 231), // Cor do ícone do AppBar
          size: 30, // Tamanho do ícone do AppBar
        ),
        backgroundColor: Color.fromARGB(255, 29, 39, 59),
        title: Text(
          'Contato',
          style: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 8, 171, 231)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Para contato:\n\nEmail: panomatheus@gmail.com\nLinkedIn: Matheus Pano',
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 35, 47, 73),
    );
  }
}
