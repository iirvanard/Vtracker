import 'dart:convert';

import 'package:vtracker/core/api/http_client.dart';
import 'package:vtracker/core/login_utils.dart';
import 'package:vtracker/core/parser.dart';

class AuthRemoteAPI {
  static const _baseUrl = 'https://auth.riotgames.com';
  static const _baseUrlApi = 'https://valorant-api.com';
  static const auth = '$_baseUrl/api/v1/authorization';
  static const userAgent = '$_baseUrlApi/v1/version';
}

abstract class AuthRemoteDatasource {
  Future<String> login({required String username, required String password});
}

class AuthDatasourceImpl implements AuthRemoteDatasource {
  HttpClient http = HttpClient();

  AuthDatasourceImpl({required this.http});

  Future<Map<String, String>> get getHeader async {
    return {
      'Accept-Language': 'en-US,en;q=0.9',
      'Content-Type': 'application/json',
      'User-Agent': await getUserAgent,
      'cookie': (await getCookie)[1],
    };
  }

  Future<String> get getCookie async {
    try {
      final response = await http.post(
        AuthRemoteAPI.auth,
        body: {
          "client_id": "play-valorant-web-prod",
          "nonce": "1",
          "redirect_uri": "https://playvalorant.com/opt_in",
          "response_type": "token id_token",
          "scope": "account openid"
        },
        headers: {"Content-Type": "application/json"},
      );

      return response.headers['set-cookie'] ?? "";
    } catch (e) {
      rethrow;
    }
  }

  Future<String> get getUserAgent async {
    try {
      final response = await http.get(AuthRemoteAPI.userAgent);

      return "RiotClient/${jsonDecode(response.body)['data']['riotClientBuild']} rso-auth (Windows;10;;Professional, x64)";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> login(
      {required String username, required String password}) async {
    try {
      // print();
      Map<String, String> header = {
        'Accept-Language': 'en-US,en;q=0.9',
        'Content-Type': 'application/json',
        'User-Agent': await getUserAgent,
      };

      header['cookie'] = Parser.getcookie(
          await getCookie, r'asid=[A-Za-z0-9_](.+)Path=/; HttpOnly; Secure');

      final response = await http.put(
        AuthRemoteAPI.auth,
        body: {
          "type": "auth",
          "username": "irvan9110",
          "password": "Imnot404@",
          "remember": true,
          "language": "en_US"
        },
        headers: header,
      );

      loginConverter(jsonDecode(parseURL(jsonDecode(response.body)['response']
              ['parameters']['uri']))['id_token']
          .split('.')[1]);

      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
