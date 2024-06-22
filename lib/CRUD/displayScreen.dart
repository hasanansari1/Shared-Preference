import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editScreen.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  void _editData(BuildContext context, int index, List<String> data) async {
    List<String>? editedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(data: data),
      ),
    );
    if (editedData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? dataList = prefs.getStringList('dataList');
      if (dataList != null) {
        // Update the data at the specified index
        dataList.setRange(index * 5, index * 5 + 5, editedData);
        // Save the updated list and navigate the screen to the display screen again.

        prefs.setStringList('dataList', dataList);
        // Refresh the display screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DisplayScreen(),
          ),
        );
      }
    }
  }

  void _deleteData(BuildContext context, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('dataList');
    if (dataList != null) {
      // Remove the data at the specified index
      dataList.removeRange(index * 5, index * 5 + 5);
      // Save the updated list
      prefs.setStringList('dataList', dataList);
      // Refresh the display screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DisplayScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Display Screen',style: TextStyle(
          fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
        ),),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String>? dataList =
                      snapshot.data!.getStringList('dataList');
                  if (dataList != null && dataList.isNotEmpty) {
                    List<Widget> dataWidgets = [];
                    for (int i = 0; i < dataList.length; i += 5) {
                      dataWidgets.add(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Data ${(i ~/ 5) + 1}:'),
                            Text('Text 1: ${dataList[i]}'),
                            Text('Text 2: ${dataList[i + 1]}'),
                            Text('Text 3: ${dataList[i + 2]}'),
                            Text('Text 4: ${dataList[i + 3]}'),
                            Text('Text 5: ${dataList[i + 4]}'),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _editData(context, i ~/ 5,
                                        dataList.sublist(i, i + 5));
                                  },
                                  child: const Text('Edit'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _deleteData(context, i ~/ 5);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: dataWidgets,
                    );
                  } else {
                    return const Text('No data found');
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
