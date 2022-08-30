import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static late SharedPreferences sharedPref;

  static init() async
  {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required key,
    required value
  }) async
  {
    if (value is String)
    {
      return await sharedPref.setString(key, value);
    }
    else if (value is int)
    {
      return await sharedPref.setInt(key, value);
    }
    else if (value is bool)
    {
      return await sharedPref.setBool(key, value);
    }
    else
    {
      return await sharedPref.setDouble(key, value);
    }
  }

  static getData({
    required key,
  })
  {
    return sharedPref.get(key);
  }

  static Future<bool> removeData({
    required String key
  }) async
  {
    return await sharedPref.remove(key);
  }

}
