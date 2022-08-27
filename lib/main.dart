import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ussd_dial/cell_number.dart'; 
import 'package:ussd_dial/locator.dart';
// import 'package:ussd_dial/home.dart';

GetIt locator = GetIt.instance; 

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dial App Demo',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'USSD Dial'),
      home: CellNumberPage(),
    );
  }
}


