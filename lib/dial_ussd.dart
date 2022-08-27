import 'package:flutter/material.dart';
import 'package:ussd_service/ussd_service.dart';

class DialUssd extends StatefulWidget {
  @override
  _DialUssdState createState() => _DialUssdState();
}

class _DialUssdState extends State<DialUssd> {
  TextEditingController _ussdCodeController = TextEditingController();
  String ussdResult = 'none';
  List<String> options = [];
  int subscriptionId = 0; // sim card subscription ID

  void makeUssdRequest([int pos = 0]) async {
    try {
      setState(() {
        ussdResult = 'Fetching USSD Result';
      });
      print('Sending USSD Code: ${options[pos]}');
      String ussdResponseMessage = await UssdService.makeRequest(
        subscriptionId,
        options[pos],
        Duration(seconds: 30), // timeout (optional) - default is 10 seconds
      );
      print("success! message: $ussdResponseMessage");
      setState(() {
        ussdResult = ussdResponseMessage;
      });
    } catch (e) {
      pos = pos + 1;
      if (pos < options.length) {
        makeUssdRequest(pos);
      } else {
        setState(() {
          ussdResult = 'Error fetching USSD response: ${e.code} - ${e.message}';
        });
      }
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dial USSD Code'),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _ussdCodeController,
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 8.0,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    options = ['*556#']; // '3#', '1#', '8824#'];
                    _ussdCodeController.text = options[0];
                    makeUssdRequest(0);
                  },
                  child: Text(
                    'Dial Code',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'USSD Result:',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Expanded(
                child: Text(
                  '$ussdResult',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
