import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'custom_drawer.dart';

class CompleteProfilePage extends StatefulWidget {
  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String? _gender = "Male";
  List<String> _languages = [];
  PlatformFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Complete Your Profile"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTitleSection(),
              Row(
                children: [
                  Expanded(child: _buildTextField("First Name")),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField("Last Name")),
                ],
              ),
              _buildFilePicker("Profile Picture"),
              _buildTextField("Username"),
              _buildTextField("Bio", maxLines: 3),
              _buildTextField("Phone Number"),
              _buildDatePicker("Birth Date"),
              _buildDropdown("Marital Status", ["Single", "Married"]),
              _buildDropdown("Nationality", ["American", "Canadian", "Other"]),
              Row(
                children: [
                  Expanded(
                      child: _buildDropdown(
                          "Country", ["USA", "Canada", "Egypt"])),
                  SizedBox(width: 10),
                  Expanded(
                      child: _buildDropdown(
                          "City", ["New York", "Toronto", "Cairo"])),
                ],
              ),
              _buildTextField("Address"),
              _buildGenderRadio(),
              _buildMultiSelect(
                  "Spoken Languages", ["English", "Spanish", "Arabic"]),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    print("Form is valid");
                  }
                },
                child: Text("Next Step"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text("Step One: Tell us more about yourself",
            style: TextStyle(color: Colors.teal)),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildDatePicker(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today)),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            initialDate: DateTime(2000),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {},
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildGenderRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: TextStyle(fontSize: 16)),
        Row(
          children: ["Male", "Female"].map((gender) {
            return Expanded(
              child: RadioListTile<String>(
                value: gender,
                groupValue: _gender,
                title: Text(gender),
                onChanged: (value) => setState(() => _gender = value),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildFilePicker(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(fontSize: 16)),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    setState(() {
                      _selectedFile = result.files.first;
                    });
                  }
                },
                child: Text("Choose File"),
              ),
            ],
          ),
          if (_selectedFile != null) ...[
            SizedBox(height: 8),
            Text(
              'Selected File: ${_selectedFile!.name}',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildMultiSelect(String label, List<String> options) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          if (value != null && !_languages.contains(value)) {
            setState(() => _languages.add(value));
          }
        },
      ),
    );
  }
}
