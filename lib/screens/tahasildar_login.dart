import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TahasildarLoginPage extends StatefulWidget {
  @override
  _TahasildarLoginPageState createState() => _TahasildarLoginPageState();
}

class _TahasildarLoginPageState extends State<TahasildarLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String userid = '';
  String password = '';
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginTahasildar() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => loading = true);

    try {
      String email = userid.contains('@') ? userid : '$userid@example.com';

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));
      Navigator.pushReplacementNamed(context, '/tahasildarHome');
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Login failed';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tahasildar Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'User ID'),
                      validator: (val) => val == null || val.isEmpty ? 'Enter User ID' : null,
                      onSaved: (val) => userid = val!.trim(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (val) => val == null || val.isEmpty ? 'Enter password' : null,
                      onSaved: (val) => password = val!,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loginTahasildar,
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
