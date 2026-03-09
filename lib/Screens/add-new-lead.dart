import 'package:crmmobile/Screens/clicktoaddcall.dart';
import 'package:crmmobile/constant.dart';
import 'package:flutter/material.dart';


class Addnewlead extends StatefulWidget {
  const Addnewlead({super.key});

  @override
  State<Addnewlead> createState() => _AddnewleadState();
}

class _AddnewleadState extends State<Addnewlead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Create new lead here"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'New Lead',
        child: const Icon(Icons.add, color: Colors.white),

        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return const CallTrackerPage();
            },
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class AddLeadForm extends StatefulWidget {
  const AddLeadForm({super.key});

  @override
  State<AddLeadForm> createState() => _AddLeadFormState();
}

class _AddLeadFormState extends State<AddLeadForm> {

  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final source = TextEditingController();
  final message = TextEditingController();
  final remarks = TextEditingController();

  String countryCode = "+91";
  String? presalesOwner;

  final List<String> owners = [
    "manoja 1",
    "manoja 2",
    "manoja 3"
  ];

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),

      child: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Add New Lead",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// PERSONAL INFO
              const Text(
                "Personal Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Row(
                children: [

                  Expanded(
                    child: TextFormField(
                      controller: firstName,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Required" : null,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextFormField(
                      controller: lastName,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 20),

              /// CONTACT INFO
              const Text(
                "Contact Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Row(
                children: [

                  SizedBox(
                    width: 90,
                    child: DropdownButtonFormField(
                      value: countryCode,
                      items: const [
                        DropdownMenuItem(value: "+91", child: Text("+91")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          countryCode = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextFormField(
                      controller: mobile,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Mobile Number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Mobile required" : null,
                    ),
                  )

                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Assignment",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField(
                value: presalesOwner,
                items: owners
                    .map((owner) =>
                        DropdownMenuItem(value: owner, child: Text(owner)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    presalesOwner = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Pre-Sales Owner",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null ? "Select owner" : null,
              ),

              const SizedBox(height: 20),

              /// ADDITIONAL INFO
              const Text(
                "Additional Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: source,
                decoration: const InputDecoration(
                  labelText: "Source",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: message,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Message",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: remarks,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Remarks",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {

                       // save fn  

                      Navigator.pop(context);

                    }

                  },
                  child: const Text("Create Lead"),
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
