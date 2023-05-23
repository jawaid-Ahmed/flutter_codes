// ignore_for_file: unnecessary_type_check, no_leading_underscores_for_local_identifiers, unnecessary_import

import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_components/lib.dart';
import 'package:flutter/material.dart';

/*
* Custom Data parser class
* @@@@@@ Methods @@@@@@@@@@@
* 1 -- getInt return integer value @input dynamic number
* 2 -- getDouble return double @input dynamic double
* 3 -- getString return string @input dynamic String
* 4 -- getDate return Date @input dynamic date
* 5 -- ucFirst return first character in upper case
* 6 -- hexToColor return color @input 8 Digit Hex code
* */
class DataParserService {
  int getInt(dynamic number) {
    if (number != null && number != "") {
      if (number is String) {
        return int.tryParse(number) ?? 0;
      } else if (number is bool) {
        return number ? 1 : 0;
      }

      return number;
    }

    return 0;
  }

  int getIntDefaultNegative(dynamic number) {
    if (number != null && number != "") {
      if (number is String) {
        return int.tryParse(number) ?? -1;
      } else if (number is bool) {
        return number ? 1 : -1;
      }

      return number;
    }

    return -1;
  }

  double getDouble(dynamic number) {
    return (number == null || number == "") ? 0.0 : double.parse('$number');
  }

  bool getBool(dynamic d) {
    if (d is String) {
      return (d == 'true' || d == '1') ? true : false;
    } else if (d is int) {
      return d == 1 ? true : false;
    } else if (d is bool) {
      return d;
    }
    return false;
  }

  String getString(dynamic string) {
    return (string != null) ? "$string" : "";
  }

  List<dynamic> getDynamicList(_data) {
    return (_data is List<dynamic>) ? _data : [];
  }

  List<InputMaskService> getMaskServiceList(_data) {
    return (_data is List<InputMaskService>) ? _data : [];
  }

  List<TextInputFormatter> getFormatterList(_data) {
    return (_data is List<TextInputFormatter>) ? _data : [];
  }

  Map<dynamic, dynamic> getDynamicMap(_data) {
    return (_data is Map<dynamic, dynamic>) ? _data : {};
  }

  Map<dynamic, dynamic> getStringDynamicMap(Map<String, dynamic> _data) {
    return (_data is Map<String, dynamic>) ? _data : {};
  }

  Map<String, dynamic> getMap(Map<dynamic, dynamic> _data) {
    return (_data is Map<String, dynamic>) ? _data : {};
  }

  DateTime getDate(dynamic string) {
    return (string != null) ? DateTime.parse(string) : DateTime.now();
  }

  String uCFirst(String value) {
    if (value.isNotEmpty) {
      return value[0].toUpperCase() + value.substring(1);
    }
    return '';
  }

  Color hexToColor(String code) {
    return HexColor.fromHex(code);
  }

  String getDashForNullString(String? str, {bool titleCase = false}) {
    return (str != null && str != "")
        ? titleCase
            ? dataParser.strToTitleCase(str)
            : str
        : "-";
  }

  String getCharForNullString(String? str, {String chr = ','}) {
    return (str != null && str != "") ? chr : '';
  }

  String getDashsForNullString(String? str) {
    return (str != null && str != "") ? str : "---";
  }

  String getUrlString(String imgStr) {
    return imgStr.replaceAll(" ", "%20");
  }

  String getPhoneNumber(String? phone) {
    InputMaskService inputMobileMask = InputMaskService();
    inputMobileMask = InputMaskService(
        mask: AppSettingConstant.kDefaultMobileNumberFormat,
        initialText: phone);
    return inputMobileMask.getMaskedText();
  }

  String getDashFromString(String imgStr) {
    imgStr = imgStr.replaceAll("-", " ");
    return imgStr.replaceAll("_", " ");
  }

  int generateRandomNumber() {
    var random = Random();

    return random.nextInt(10000);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;

    var c = cos;

    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }

  getMobileNumberWithFormat(String text) {
    return InputMaskService(
            mask: AppSettingConstant.kDefaultMobileNumberFormat,
            initialText: text)
        .getMaskedText();
  }

  getMobileNumberWithoutFormat(String text) {
    return InputMaskService(
            mask: AppSettingConstant.kDefaultMobileNumberFormat,
            initialText: text)
        .getMaskedText();
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  dateFormater(dateString) {
    if (dateString == '' || dateString == null) {
      var date = DateTime.now();
      DateFormat dateFormat = DateFormat("dd MMM yyyy");
      return dateFormat.format(date);
    }
    var date = DateTime.parse(dataParser.getString(dateString));
    DateFormat dateFormat = DateFormat("dd MMM yyyy");
    return dateFormat.format(date);
  }

  String dateDisplayFormater(dateString) {
    var date = DateTime.parse(dataParser.getString(dateString));
    DateFormat dateFormat = DateFormat("MMM dd, yyyy");
    return dateFormat.format(date);
  }

  dateTimeDisplayFormater(dateString) {
    var date = DateTime.parse(dataParser.getString(dateString));
    DateFormat dateFormat = DateFormat("MMM dd, yyyy");
    return dateFormat.format(date);
  }

  String base64Encoder(String data) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(data);
  }

  String base64Decoder(String base64Encoded) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(base64Encoded);
  }

  String mapTobase64Encoder(Map<String, dynamic> map) {
    return base64Encoder(map.toString());
  }

  String toCapitalized(str) => str.length > 0
      ? '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}'
      : '';

  String strToTitleCase(str) => str
      .replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((d) => toCapitalized(d))
      .join(' ');

  String encodeMap(Map<String, dynamic> map) {
    return json.encode(map);
  }

  Map<String, dynamic> decodeMap(String map) {
    return json.decode(map);
  }

  Map<String, String> encodeBase64Value(Map<String, dynamic> map) {
    Map<String, String> t = {};
    map.forEach((key, value) {
      t[key] = base64Encoder(value);
    });
    return t;
  }

  Map<String, String> dencodeBase64Value(Map<String, dynamic> map) {
    Map<String, String> t = {};
    map.forEach((key, value) {
      t[key] = base64Decoder(value);
    });
    return t;
  }

  base64StringToMapDecoder(String base64Encoded) {
    try {
      return jsonEncode(base64Decoder(base64Encoded));
    } catch (e) {
      return {};
    }
  }

  String getCapitalizeFirst(String string) {
    if (string.isNotEmpty) {
      return "${string[0].toUpperCase()}${string.substring(1)}";
    }
    return string;
  }

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  String getFirstWordFromString(String str, {split = ' '}) {
    int startIndex = 0, indexOfSpace;
    indexOfSpace = str.indexOf(split, startIndex);
    if (indexOfSpace == -1) {
      return str;
    }
    startIndex = indexOfSpace + 1;
    return str.substring(0, indexOfSpace);
  }

  String getTwoWordFromString(String str) {
    List<String> splitted = str.split(' ');

    if (splitted.length < 2) {
      return str;
    }
    return "${splitted[0]} ${splitted[1]}";
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

class InputValidation {
  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  String? validateEmail(String? txt, {label = "Email Address"}) {
    if (txt == null || txt.isEmpty) {
      return "$label is required!";
    }
    if (!isValidEmail(txt)) {
      return "Invalid Email Address";
    } else {
      return null;
    }
  }

  String? validateMin(String? txt, int length, {label = "Text Field"}) {
    if (txt == null || txt.isEmpty) {
      return "$label is required!";
    }
    if (txt.length < length) {
      return "$label must have $length characters";
    } else {
      return null;
    }
  }

  List<InputMaskService> getMaskServiceList(_data) {
    return (_data is List<InputMaskService>) ? _data : [];
  }

  String? validateConfirmPassword(String? txt, String? otherTxt,
      {label = "Password", otherLabel = "Confirm Password"}) {
    if (txt == null || txt.isEmpty) {
      return "${dataParser.strToTitleCase(label)} is required!";
    }
    if (txt != otherTxt) {
      return "${dataParser.uCFirst(label)} must be equal to $otherLabel";
    } else {
      return null;
    }
  }

  String? validatePassword(String? txt, {label = "Password"}) {
    if (txt == null || txt.isEmpty) {
      return "${dataParser.strToTitleCase(label)} is required!";
    }
    if (txt.length < 8) {
      return "${dataParser.strToTitleCase(label)} must have 8 characters";
    }
    if (!txt.contains(RegExp(r'[A-Z]'))) {
      return "${dataParser.strToTitleCase(label)} must have uppercase";
    }
    if (!txt.contains(RegExp(r'[0-9]'))) {
      return "${dataParser.strToTitleCase(label)} must have digits";
    }
    if (!txt.contains(RegExp(r'[a-z]'))) {
      return "${dataParser.strToTitleCase(label)} must have lowercase";
    }
    if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
      return "${dataParser.strToTitleCase(label)} must have special characters";
    } else {
      return null;
    }
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

DataParserService dataParser = DataParserService();

class ProjectDataFormatter {
  // String displayPropertyText(
  //     String? name, String? unit, String? block, String? streetAddress) {
  //   return "${dataParser.strToTitleCase(name)} ${dataParser.strToTitleCase(unit)} ${block != '' || streetAddress != '' ? '${dataParser.strToTitleCase(block)} ${dataParser.strToTitleCase(streetAddress)}' : ''}";
  // }

  String displayPropertyName(String? name) {
    return dataParser.strToTitleCase(name);
  }

  String displayPropertyAddress({
    String? name,
    String? unit,
    String? block,
    String? streetAddress,
    String? zipcode,
  }) {
    String address = '';
    if ((name ?? '').isNotEmpty) {
      address = '${dataParser.strToTitleCase(name)}, ';
    }
    if ((unit ?? '').isNotEmpty) {
      address =
          '$address${dataParser.strToTitleCase(unit)}${(block ?? '').isNotEmpty ? '/' : ', '}';
    }
    if ((block ?? '').isNotEmpty) {
      address = '$address${dataParser.strToTitleCase(block)}, ';
    }
    if ((streetAddress ?? '').isNotEmpty) {
      address = '$address${dataParser.strToTitleCase(streetAddress)}, ';
    }
    if ((zipcode ?? '').isNotEmpty) {
      address = '$address${dataParser.strToTitleCase(zipcode)}, ';
    }

    if (address.isNotEmpty) {
      address = address.substring(0, address.length - 2);
    }
    return address;
  }

  String displaySPAddressText(
    HTUserModel user,
  ) {
    if (user.spDetail.address == '') {
      return '--';
    }
    return "${user.spDetail.address}${dataParser.getCharForNullString(user.spDetail.address)} ${user.spDetail.city.name}${dataParser.getCharForNullString(user.spDetail.city.name)} ${user.spDetail.county.name}${dataParser.getCharForNullString(user.spDetail.county.name)} ${user.spDetail.state.name}${dataParser.getCharForNullString(user.spDetail.state.name)} ${user.spDetail.zipcode.code}${dataParser.getCharForNullString(user.spDetail.zipcode.code, chr: '.')}";
  }

  String? displayShortDetail(String? detail) {
    return detail != ''
        ? (detail?.length ?? 0) > 30
            ? detail?.substring(0, 30)
            : detail
        : null;
  }

  String getShortUserName(firstName, lastName) {
    return "${dataParser.getCapitalizeFirst(firstName[0])}${dataParser.getCapitalizeFirst(lastName[0])}";
  }

  String displayBlockName(String block) {
    return '$block ${!(block).toLowerCase().contains('block') ? 'Block' : ''}';
  }
}

ProjectDataFormatter projectDataFormatter = ProjectDataFormatter();

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
