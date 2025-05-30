import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:samadhan_saathi/components/app_drawer.dart';

class ComplaintHistoryPage extends StatefulWidget {
  @override
  _ComplaintHistoryPageState createState() => _ComplaintHistoryPageState();
}

class _ComplaintHistoryPageState extends State<ComplaintHistoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  late Stream<QuerySnapshot> complaintStream;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      complaintStream = _firestore
          .collection('complaints')
          .where('userId', isEqualTo: user!.uid)
          .orderBy('date', descending: true)
          .snapshots();
    } else {
      complaintStream = const Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Complaint History')),
        body: Center(child: Text('Please login to see your complaints')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Complaint History')),
      drawer: const AppDrawer(), 
      body: StreamBuilder<QuerySnapshot>(
        stream: complaintStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Firestore error: ${snapshot.error}');
            return Center(child: Text('Error fetching complaints'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final complaints = snapshot.data!.docs;

          if (complaints.isEmpty) {
            return Center(child: Text('No complaints found'));
          }

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final doc = complaints[index];
              final data = doc.data() as Map<String, dynamic>;

              final title = data['title'] ?? 'No Title';
              final description = data['description'] ?? 'No Description';
              final Timestamp? timestamp = data['date'];
              String dateString = 'No Date';
              if (timestamp != null) {
                dateString = DateFormat('dd MMM yyyy, hh:mm a').format(timestamp.toDate());
              }
              final status = data['status'] ?? 'Pending';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(description),
                      SizedBox(height: 6),
                      Text('Date: $dateString'),
                      Text('Status: $status'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
