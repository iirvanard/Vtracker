import 'dart:convert';

List<String> loginConverter(String body) {
  print(nickname(body));
  return [];
}

String nickname(String token) {
  try {
    final decodedToken =
        utf8.decode(base64Url.decode(base64.normalize("$token=")));
    final nickname = json.decode(decodedToken)["acct"];
    return "${nickname['game_name']}#${nickname['tag_line']}";
  } catch (e) {
    final decodedToken = utf8.decode(base64.decode("$token="));
    final nickname = json.decode(decodedToken)["acct"];
    return "${nickname['game_name']}#${nickname['tag_line']}";
  }
}

String parseURL(uris) {
  dynamic uri = json.decode(
      json.encode(Uri.parse(uris.replaceAll("#", "?")).queryParameters));
  return (json.encode({
    "access_token": uri['access_token'],
    "id_token": uri['id_token'],
    "expired": uri['expires_in']
  }));
}
