import 'package:flutter/material.dart';
import 'package:framework/word_response.dart';

import 'detail_screen.dart';

class ListOfWords extends StatelessWidget {
  const ListOfWords({Key? key, required this.word}) : super(key: key);
  final List<WordResponse> word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Find Word'),),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(word[index]),
                    ),
                  );
                },
                title: Text('${index + 1}. ${word[index].word}'),
              ),
          separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
          itemCount: word.length),
    );
  }
}
