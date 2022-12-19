import 'package:http/http.dart' as http;

class HttpService {
  Future<http.Response?> getWordFromDictionary(String endpoint) async {
    http.Response? response;
    String url = 'https://api.dictionaryapi.dev/api/v2/entries/en/';
    final uri = Uri.parse('$url$endpoint');

    try {
      response = await http.get(uri);
    } on Exception catch (e) {
      throw e;
    }
    return response;
  }
}
