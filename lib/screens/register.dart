import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  String name = '';
  String gender = 'Male'; 
  String gutnumber = '';
  String adhar = '';
  String email = '';
  String password = '';
  
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> genders = ['Male', 'Female', 'Other'];

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => loading = true);
    
    try {
      // Register user using the provided email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional details in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'gender': gender,
        'gutnumber': gutnumber,
        'adhar': adhar,
        'email': email,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful!')));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Error occurred';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (val) => val == null || val.isEmpty ? 'Enter name' : null,
                      onSaved: (val) => name = val!.trim(),
                    ),
                    DropdownButtonFormField<String>(
                      value: gender,
                      decoration: InputDecoration(labelText: 'Gender'),
                      items: genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                      onChanged: (val) => setState(() => gender = val!),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Gutnumber'),
                      validator: (val) => val == null || val.isEmpty ? 'Enter gutnumber' : null,
                      onSaved: (val) => gutnumber = val!.trim(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Adhar Number'),
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Enter Adhar number';
                        if (val.length != 12) return 'Adhar must be 12 digits';
                        return null;
                      },
                      onSaved: (val) => adhar = val!.trim(),
                    ),
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
                      onPressed: register,
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
