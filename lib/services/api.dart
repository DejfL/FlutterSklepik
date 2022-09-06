import 'package:http/http.dart';

Future<Response> apiGetRequest(String link) async {
  return await get(
    Uri.parse(
      _getApiLink(
        link,
      ),
    ),
  );
}

Future<Response> apiPostRequest(String link, {var body}) async {
  return await post(
    Uri.parse(
      _getApiLink(
        link,
      ),
    ),
    headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
    },
    body: body,
  );
}

Future<Response> apiDeleteRequest(String link) async {
  return await delete(
    Uri.parse(
      _getApiLink(
        link,
      ),
    ),
    headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
    },
  );
}

String _getApiLink(String link) {
  return 'https://dummyjson.com/' + link;
}
