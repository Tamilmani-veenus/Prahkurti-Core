import 'dart:io';
import 'package:http/http.dart' as http;

import '../utilities/requestconstant.dart';

class ApiManager{
  static var client = http.Client();

  static Future<dynamic> postAPICall(String url, String param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.post(uri, headers: RequestConstant.postHeaders(), body: param);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  static Future<dynamic> deleteBodyAPICall(String url, String param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.delete(uri, headers: RequestConstant.headers, body: param);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  static Future<dynamic> postCall(String url) async {
    print("Calling API: $url");

    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.post(uri,
          headers: RequestConstant.postHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  static Future<dynamic> postAPICallImage(String url, String body, File image) async {
    // print("Calling API: $url");
    // print("Calling parameters: $param");
    var responseJson;
    try {
      var uri = Uri.parse(url);
      var method = body;
      // Map<String, dynamic> bodyData = body.toJson();
      final response =  await http.MultipartRequest(method, uri );
      responseJson = _multipartresponse(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  static Future<dynamic> getAPICall(String url) async {
    print("Calling API: $url");
    var uri = Uri.parse(url);
    var responseJson;
    try {
      final response =  await client.get(uri,
          headers: RequestConstant.getHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }
  ///-------------------delete ------------------------------
  static Future<dynamic> deletebuttonAPICall(String url, String param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.delete(uri, headers: RequestConstant.headers, body: param);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }


  static Future<dynamic> putUpdateAPIButton(String url, String param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.put(uri, headers:RequestConstant.postHeaders(), body: param);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  static Future<dynamic> putAPICall(String url) async {
    print("Calling API: $url");

    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.put(uri,
          headers: RequestConstant.postHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  static Future<dynamic> deleteAPICall(String url) async {
    print("Calling API: $url");

    var responseJson;
    try {
      var uri = Uri.parse(url);
      final response =  await client.delete(uri,
          headers: RequestConstant.postHeaders());
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(RequestConstant.NOINTERNETCONNECTION);
    }
    return responseJson;
  }

  /// --------- This one for image path --------------

  static dynamic _multipartresponse(http.MultipartRequest response) {
    if (response.files == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Status code: ${response.files}');
    }
  }

  static dynamic _response(http.Response response) {

    switch (response.statusCode) {

      case 200:
      case 201:
        return response.body.toString();

      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());

      case 500:
        return response.body.toString(); // allow parsing message

      default:
        throw FetchDataException(
            'Error occurred while communication with server with statusCode: ${response.statusCode}');
    }
  }

}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
