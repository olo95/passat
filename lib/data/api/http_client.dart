import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:passat/data/api/api_exception.dart';

class HttpClient {
  HttpClient._();

  static final HttpClient _instance = HttpClient._();

  factory HttpClient() => _instance;

  Future<Result<dynamic>> getRequest(String path) async {
    Response response;

    try {
      response = await get(path);
      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          return Result<dynamic>.value(null);
        } else {
          return Result<dynamic>.value(jsonDecode(response.body));
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        return Result<dynamic>.error(ClientErrorException());
      } else if (statusCode >= 500 && statusCode < 600) {
        return Result<dynamic>.error(ServerErrorException());
      } else {
        return Result<dynamic>.error(UnknownException());
      }
    } on SocketException {
      return Result<dynamic>.error(ConnectionException());
    }
  }
}
