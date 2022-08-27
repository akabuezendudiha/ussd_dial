import 'package:flutter/material.dart';
import 'package:ussd_dial/cell_number.dart';
import 'package:ussd_dial/main.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:ussd_dial/services/api.dart';
import 'package:ussd_dial/services/shared_pref.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pref = locator<AppSharedPreference>();
  final _api = locator<ApiService>();
  final TextEditingController _ussdCodeController = TextEditingController();
  String _cellNumber;

  Future<void> loadVoucher() async {
    if (_cellNumber == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please set your Cell Number'),
      ));
      return;
    } else if (_ussdCodeController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter 10 digits Voucher.'),
      ));
      return;
    }
    showLoader();
    var result = await _api.loadVoucher(_cellNumber, _ussdCodeController.text);
    Loader.hide();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$result'),
    ));
  }

  Future<void> getCellNumber() async {
    _cellNumber = await _pref.getCellNumber();
    if (_cellNumber == '') {
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => CellNumberPage()));
      _cellNumber = await _pref.getCellNumber();
    }
    setState(() {
      if (_cellNumber == '') _cellNumber = 'None';
    });
  }

  void showLoader() {
    Loader.show(
      context,
      progressIndicator: CircularProgressIndicator(),
      themeData: Theme.of(context).copyWith(canvasColor: Colors.blue),
      overlayColor: Colors.white60,
    );
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
        title: Text(widget.title),
        actions: [
          TextButton(
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(width: 4.0),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CellNumberPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 24.0,
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _ussdCodeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: 28.0,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Voucher PIN',
              ),
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () => loadVoucher(),
              child: Text(
                'Dial Code',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
