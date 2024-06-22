import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'displayScreen.dart';


class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();



  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('dataList');
    dataList ??= [];
    dataList.add(_controller1.text);
    dataList.add(_controller2.text);
    dataList.add(_controller3.text);
    dataList.add(_controller4.text);
    dataList.add(_controller5.text);
    prefs.setStringList('dataList', dataList);

    // Clear text fields
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    _controller5.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                    if (_formKey.currentState!.validate()) {
                      // Save data to shared preferences
                      saveData();
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DisplayScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}