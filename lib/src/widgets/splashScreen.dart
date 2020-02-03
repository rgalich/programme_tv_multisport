import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(27, 119, 0, 1)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                width: 200.0,
              ),
              Text(
                'Télé Sportive',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
              SizedBox(height: 100.0,),
              CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(27, 119, 0, 1),
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
