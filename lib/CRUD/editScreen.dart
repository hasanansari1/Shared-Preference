import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  final List<String> data;

  const EditScreen({super.key, required this.data});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for text controllers
    _controller1.text = widget.data[0];
    _controller2.text = widget.data[1];
    _controller3.text = widget.data[2];
    _controller4.text = widget.data[3];
    _controller5.text = widget.data[4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Edit Data', style: TextStyle(
          fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controller1,
                decoration: const InputDecoration(labelText: 'Text 1'),
              ),
              TextFormField(
                controller: _controller2,
                decoration: const InputDecoration(labelText: 'Text 2'),
              ),
              TextFormField(
                controller: _controller3,
                decoration: const InputDecoration(labelText: 'Text 3'),
              ),
              TextFormField(
                controller: _controller4,
                decoration: const InputDecoration(labelText: 'Text 4'),
              ),
              TextFormField(
                controller: _controller5,
                decoration: const InputDecoration(labelText: 'Text 5'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save edited data and pop the screen
                    saveEditedData();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveEditedData() {
    List<String> editedData = [
      _controller1.text,
      _controller2.text,
      _controller3.text,
      _controller4.text,
      _controller5.text
    ];
    Navigator.pop(context, editedData);
  }
}
