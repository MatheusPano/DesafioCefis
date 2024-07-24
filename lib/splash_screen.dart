import 'package:flutter/material.dart';
import 'package:cefis/home_screen.dart'; // Certifique-se de ter uma HomeScreen para redirecionar

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 35, 47, 73),
              Color.fromARGB(255, 35, 47, 73),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('images/logo.png', width: 400, height: 350),
              SizedBox(height: 200),
              Text(
                'Learnance',
                style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 171, 231)),
              ),
              SizedBox(height: 20),
              Text(
                'Desenvolvido por Matheus Pano',
                style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 8, 171, 231)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
