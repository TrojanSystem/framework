import 'dart:io';

import 'package:flutter/material.dart';
import 'package:framework/http_services.dart';
import 'package:framework/word_response.dart';

class WordRepository {
  Future<List<WordResponse>?> getWord(String query, context) async {
    try {
      final response = await HttpService().getWordFromDictionary(query);
      if (response!.statusCode == 200) {
        final result = wordResponseFromJson(response.body);
        return result;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpService catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }
}
