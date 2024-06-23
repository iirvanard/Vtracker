import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vtracker/core/parser.dart';

class HttpClient {
  Future<http.Response> get(String baseUrl,
      {dynamic headers, dynamic body}) async {
    try {
      final url = body == null ? baseUrl : '$baseUrl/${Parser.parse(body)}';
      var response = await http.get(Uri.parse(url), headers: headers);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(String baseUrl,
      {dynamic headers, dynamic body}) async {
    try {
      var response = await http.post(Uri.parse(baseUrl),
          headers: headers, body: jsonEncode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> put(String baseUrl,
      {dynamic body, dynamic headers}) async {
    try {
      var response = await http.put(Uri.parse(baseUrl),
          headers: headers, body: jsonEncode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(String baseUrl,
      {dynamic body, dynamic headers}) async {
    try {
      var response = await http.delete(Uri.parse(baseUrl),
          headers: headers, body: jsonEncode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
