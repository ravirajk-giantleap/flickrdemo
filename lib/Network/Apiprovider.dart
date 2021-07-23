
import 'dart:convert';
import 'dart:io';

import 'package:flickrdemo/Exception/CustomException.dart';
import 'package:http/http.dart' as http;


class ApiProvider {
 final String _baseUrl =  'https://api.flickr.com/services/feeds/';

 
  //future get
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl+url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      );
      responseJson = _response(response);
      print(_baseUrl+url);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:

      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}