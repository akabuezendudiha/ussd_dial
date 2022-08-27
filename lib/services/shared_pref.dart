import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  SharedPreferences _pref;

  Future<SharedPreferences> get sharedPref async {
    if (_pref != null) {
      return _pref;
    }

    _pref = _pref ?? await SharedPreferences.getInstance();
    return _pref;
  }

  Future<String> getCellNumber() async {
    final pref = await sharedPref;
    return pref.getString('cell') ?? '';
  }

  Future<bool> setCellNumber(String cellNumber) async {
    final pref = await sharedPref;
    return await pref.setString('cell', cellNumber);
  }

}