import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = '';
  String gender = 'Male';
  String gutnumber = '';
  String adhar = '';
  String email = '';
  String password = '';

  bool loading = false;
  bool _obscurePassword = true;

  List<String> genders = ['Male', 'Female', 'Other'];

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => loading = true);

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'gender': gender,
        'gutnumber': gutnumber,
        'adhar': adhar,
        'email': email,
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration Successful!')));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Error occurred')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child:
            loading
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/logo/logo.jpg', height: 80),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty)
                                  return 'Enter name';
                                if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val))
                                  return 'Name should not contain numbers or symbols';
                                return null;
                              },
                              onSaved: (val) => name = val!.trim(),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: gender,
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                                prefixIcon: Icon(Icons.wc),
                                border: OutlineInputBorder(),
                              ),
                              items:
                                  genders
                                      .map(
                                        (g) => DropdownMenuItem(
                                          value: g,
                                          child: Text(g),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) => setState(() => gender = val!),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Gut Number',
                                prefixIcon: Icon(Icons.map),
                                border: OutlineInputBorder(),
                              ),
                              validator:
                                  (val) =>
                                      val == null || val.isEmpty
                                          ? 'Enter gut number'
                                          : null,
                              onSaved: (val) => gutnumber = val!.trim(),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Adhar Number',
                                prefixIcon: Icon(Icons.credit_card),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 12,
                              validator: (val) {
                                if (val == null || val.isEmpty)
                                  return 'Enter Adhar number';
                                if (val.length != 12)
                                  return 'Adhar must be 12 digits';
                                return null;
                              },
                              onSaved: (val) => adhar = val!.trim(),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty)
                                  return 'Enter email';
                                if (!val.contains('@'))
                                  return 'Enter valid email';
                                return null;
                              },
                              onSaved: (val) => email = val!.trim(),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator:
                                  (val) =>
                                      val == null || val.length < 6
                                          ? 'Password must be at least 6 characters'
                                          : null,
                              onSaved: (val) => password = val!,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
