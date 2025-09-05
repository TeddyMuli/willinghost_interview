import 'package:flutter/material.dart';
import '../services/get_bnb.dart';
import '../services/update_bnb.dart';

class EditBnbPage extends StatefulWidget {
  final int bnbId;
  const EditBnbPage({Key? key, required this.bnbId}) : super(key: key);

  @override
  State<EditBnbPage> createState() => _EditBnbPageState();
}

class _EditBnbPageState extends State<EditBnbPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _availability = true;
  bool _isLoading = false;
  String? _error;
  bool _loaded = false;

  Future<void> _loadBnb() async {
    try {
      final bnb = await FetchBnb.fetchBnb(widget.bnbId);
      _nameController.text = bnb.name;
      _locationController.text = bnb.location;
      _priceController.text = bnb.pricePerNight.toString();
      _availability = bnb.availability;
      setState(() {
        _loaded = true;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading BnB: $e';
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final bnbData = {
        'name': _nameController.text,
        'location': _locationController.text,
        'price_per_night': double.tryParse(_priceController.text) ?? 0.0,
        'availability': _availability,
      };
      final response = await UpdateBnb.updateBnb(widget.bnbId, bnbData);
      if (response.statusCode == 200) {
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _error = 'Failed to update BnB: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBnb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit BnB')),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter a name'
                          : null,
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter a location'
                          : null,
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price per Night',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter a price';
                        final price = double.tryParse(value);
                        if (price == null || price < 0)
                          return 'Enter a valid price';
                        return null;
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Available'),
                      value: _availability,
                      onChanged: (val) => setState(() => _availability = val),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 16),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Update BnB'),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
