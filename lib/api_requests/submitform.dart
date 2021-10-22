import 'dart:convert';

import 'package:http/http.dart' as http;

class SubmitForm {
  final String baseUrl = "baseUrl";

  postApi(apiUrl, data) async {
    var _fullUrl = baseUrl + apiUrl;

    return await http
        .post(Uri.parse(_fullUrl), body: jsonEncode(data), headers: {});
  }
}
