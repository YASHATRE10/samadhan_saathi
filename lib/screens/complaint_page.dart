import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show basename;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samadhan_saathi/components/app_drawer.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _matterController = TextEditingController();

  File? _imageFile;
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // 1️⃣ Upload Text Fields to Firebase Firestore
      final docRef = await FirebaseFirestore.instance.collection('complaints').add({
        'title': _titleController.text.trim(),
        'subject': _subjectController.text.trim(),
        'matter': _matterController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      // 2️⃣ Upload Image to Node.js + MongoDB (if selected)
      if (_imageFile != null) {
        final uri = Uri.parse("http://192.168.0.118:5000/upload");
        final request = http.MultipartRequest('POST', uri);
        final fileName = basename(_imageFile!.path);
        request.fields['complaintId'] = docRef.id; // optional: link image to Firebase doc
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          _imageFile!.path,
          filename: fileName,
        ));

        final response = await request.send();
        if (response.statusCode != 200) {
          final error = await response.stream.bytesToString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image upload failed: $error')),
          );
          return;
        }
      }

      // ✅ Final Success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully!')),
      );

      // Clear form
      _titleController.clear();
      _subjectController.clear();
      _matterController.clear();
      setState(() {
        _imageFile = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lodge a Complaint'),
        backgroundColor: Colors.green[800],
      ),
      drawer: const AppDrawer(), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter subject' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matterController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Matter',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter complaint details'
                    : null,
              ),
              const SizedBox(height: 20),
              if (_imageFile != null)
                Column(
                  children: [
                    Image.file(_imageFile!, height: 150),
                    TextButton.icon(
                      icon: const Icon(Icons.delete_forever, color: Colors.red),
                      label: const Text('Remove Image',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        setState(() {
                          _imageFile = null;
                        });
                      },
                    ),
                  ],
                ),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Image (Optional)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  minimumSize: const Size.fromHeight(45),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitComplaint,
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Complaint'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
