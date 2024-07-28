import 'package:flutter/services.dart';

class AppUtils {
  const AppUtils._();

  // static Future<void> getStoredData() async {
  //   await AuthUtils.getAuthLocalData();
  // }

  static List<TextInputFormatter>? phoneInputFormatters() => [
        LengthLimitingTextInputFormatter(10),
        // FilteringTextInputFormatter.allow(
        // RegExp(RegexConstants.pinCodeFormat),
        // ),
        // FilteringTextInputFormatter.deny(RegExp('^[0-5]+')),
      ];
}
