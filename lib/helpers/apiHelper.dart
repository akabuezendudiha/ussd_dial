import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ussd_dial/utils/exceptions.dart';

class ApiBaseHelper { 
  final String _baseUrl = 'https://6db22dac953c.ngrok.io/api/';
  final client = http.Client();

  Future<dynamic> post({
    String url,
    Map<String, dynamic> body, 
  }) async {
    var responseJson;
    try {
      Map<String, String> header = {};
      header.addAll({'Accept': '*/*'});      
      header.addAll({'Content-Type': 'application/json'});      
      final response = await client.post(Uri.parse('$_baseUrl$url'),
          body: json.encode(body), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 404:
        throw UnreachableEndpointException(response.body);
      case 400:        
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorisedException(response.body);
      default:
        throw FetchDataException('Internal server error ');
    }
  }
}
