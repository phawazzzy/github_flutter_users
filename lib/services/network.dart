import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  final String url;
  NetworkHelper({this.url});

  Future<dynamic> getData() async{
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.contentLength);
      return jsonDecode(response.body);
    }
    else {
      print(response.statusCode);
    }
  }
}