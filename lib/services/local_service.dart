import 'package:mobile_app/core/constant/key_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  Future<String?> getLocalToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConstant.accessTokenKey);
  }
  Future<bool?> isDriverAccount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstant.isDriverKey);
  }
}
