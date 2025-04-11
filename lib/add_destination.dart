import 'package:flutter/material.dart';
import 'package:tajawul/custom_drawer.dart';

class AddDestinationPage extends StatelessWidget {
  const AddDestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Add Destination"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFFCF7F0),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DestinationForm(),
        ),
      ),
    );
  }
}

class DestinationForm extends StatefulWidget {
  const DestinationForm({super.key});

  @override
  State<DestinationForm> createState() => _DestinationFormState();
}

class _DestinationFormState extends State<DestinationForm> {
  bool isOpen24Hours = false;
  String? selectedCity;
  String? selectedType;
  String? selectedCountry;
  String? selectedPriceRange;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const sectionTextStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1D4D4F));

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text("General Info", style: sectionTextStyle),
          const Divider(),
          _buildTextField(label: 'Destination Name'),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: "Destination Type",
                  items: const ["Museum", "Park", "Hotel"],
                  onChanged: (val) => selectedType = val,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdown(
                  label: "Country",
                  items: const ["USA", "Egypt", "France"],
                  onChanged: (val) => selectedCountry = val,
                ),
              ),
            ],
          ),
          _buildTextField(label: 'Description', maxLines: 3),
          _buildTextField(label: 'Established At', hint: 'mm/dd/yyyy'),
          const SizedBox(height: 20),
          const Text("Location Details", style: sectionTextStyle),
          const Divider(),
          _buildDropdown(
            label: "City",
            items: const ["Cairo", "Paris", "NYC"],
            onChanged: (val) => selectedCity = val,
          ),
          _buildTextField(label: "Address"),
          Row(
            children: [
              Expanded(child: _buildTextField(label: "Longitude")),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField(label: "Latitude")),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Operating Hours & Pricing", style: sectionTextStyle),
          const Divider(),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Open 24 Hours"),
            value: isOpen24Hours,
            onChanged: (val) {
              setState(() {
                isOpen24Hours = val!;
              });
            },
          ),
          if (!isOpen24Hours)
            Row(
              children: [
                Expanded(
                    child:
                        _buildTextField(label: "Open Time", hint: "--:-- --")),
                const SizedBox(width: 10),
                Expanded(
                    child:
                        _buildTextField(label: "Close Time", hint: "--:-- --")),
              ],
            ),
          _buildDropdown(
            label: "Price Range",
            items: const ["Free", "\$", "\$\$", "\$\$\$"],
            onChanged: (val) => selectedPriceRange = val,
          ),
          const SizedBox(height: 20),
          const Text("Contact & Social Media", style: sectionTextStyle),
          const Divider(),
          Wrap(
            spacing: 8,
            children: [
              _buildChip("+ Add Phone Number"),
              _buildChip("+ Add Website"),
              _buildChip("+ Add Social Media"),
            ],
          ),
          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // handle submit
                  Navigator.pushNamed(context, '/uplodeDestinationImages');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Create Destination"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String label, String? hint, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        validator: (val) => val == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildChip(String label) {
    return ActionChip(
      label: Text(label),
      backgroundColor: const Color(0xFFEBF1EE),
      shape: StadiumBorder(
        side: BorderSide(color: Colors.brown),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/uplodeDestinationImages');
      },
    );
  }
}
