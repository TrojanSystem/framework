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

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(e.message),
            content: const Icon(
              Icons.wifi_off,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ]),
      );
      throw e;
    } on HttpService catch (e) {
      print('No Http Service');
      throw e;
    } on FormatException catch (e) {
      print('No Format Exception');
      throw e;
    }
  }
}
