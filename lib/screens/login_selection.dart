import 'package:flutter/material.dart';

class LoginSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Selection')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/userLogin'); // Define User Login screen route
                },
                child: Text('User Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tahasildarLogin'); // Define Tahasildar Login screen route
                },
                child: Text('Tahasildar Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register'); // Define Registration screen route
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
