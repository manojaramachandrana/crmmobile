import 'package:crmmobile/constant.dart';
import 'package:flutter/material.dart';


class Addnewlead extends StatelessWidget{
  const Addnewlead({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Create new lead here"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        tooltip: 'New Lead',
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}