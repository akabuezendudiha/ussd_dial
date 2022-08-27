import 'package:flutter/material.dart';
import 'package:ussd_dial/main.dart';
import 'package:ussd_dial/services/shared_pref.dart';

class CellNumberPage extends StatefulWidget {
  @override
  _CellNumberPageState createState() => _CellNumberPageState();
}

class _CellNumberPageState extends State<CellNumberPage> {
  final TextEditingController _cellNumberController = TextEditingController();

  Future<void> saveCellNumber() async {
    if (_cellNumberController.text.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Invalid Cell Number! Please enter 11 digits cell number.'),
      ));
    } else {
      locator<AppSharedPreference>().setCellNumber(_cellNumberController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cell Number successfully saved.'),
      ));
    }
  }

  Future<void> getCellNumber() async {
    _cellNumberController.text =
        await locator<AppSharedPreference>().getCellNumber();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _cellNumberController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCellNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cell Number',
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _cellNumberController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              autofocus: false,
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  hintText: 'Enter MTN Number',
                  prefixIcon: Icon(Icons.sim_card)),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () => saveCellNumber(),
              child: Text('Save Cell Number',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
