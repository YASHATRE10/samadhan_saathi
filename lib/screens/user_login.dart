import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => loading = true);

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));

      // Navigate to home/dashboard
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Authentication failed')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter email';
                  if (!val.contains('@')) return 'Enter valid email';
                  return null;
                },
                onSaved: (val) => email = val!.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) => val == null || val.length < 6 ? 'Password at least 6 chars' : null,
                onSaved: (val) => password = val!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
