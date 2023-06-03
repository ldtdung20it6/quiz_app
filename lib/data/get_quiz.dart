import 'dart:convert';
import 'package:quiz_app/url_config.dart';
import 'package:http/http.dart' as http;

class getQuiz {
  get() async {
    var res = await http.get(Uri.parse(URLConfig.BASE_URL));
    var data = jsonDecode(res.body.toString());
    return data;
  }
}
