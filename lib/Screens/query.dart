import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class leadsquery extends StatefulWidget {
  const leadsquery({super.key});

  @override
  State<leadsquery> createState() => leadsqueryState();
}

// ignore: camel_case_types
class leadsqueryState extends State<leadsquery> {
  List<Map<String, dynamic>> leads = [];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchleads();
  }

  Future<void> fetchleads() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("leads")
        .orderBy('createdDate', descending: true)
        .limit(50)
        .get();
    setState(() {
      leads = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (leads.isEmpty) {
      return Scaffold(body: Center(child: Text("no data found in leads")));
    }

    final columns = leads.first.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Leads')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: columns
                .map((col) => DataColumn(label: Text(col)))
                .toList(),
            rows: leads.map((lead) {
              return DataRow(
                cells: columns.map((col) {
                  return DataCell(Text(lead[col]?.toString() ?? '-'));
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
